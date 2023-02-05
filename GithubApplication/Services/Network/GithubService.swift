//
//  GithubService.swift
//  GithubNavigation
//
//  Created by Janus Jordan on 2/2/23.
//

import Foundation


protocol GithubServiceProtocol {
    var urlSession: URLSession { get set }
    var baseURL: String { get }
    func fetchUsers(lastId: Int64, _ completion: @escaping (Result<[GithubUser], NetworkError>) -> Void)
    func fetchUser(loginKey: String, _ completion: @escaping (Result<GithubUserDetails?, NetworkError>) -> Void)
}


class GithubService: GithubServiceProtocol {
    var urlSession = URLSession.shared
    var baseURL: String = "https://api.github.com/users"
    func fetchUsers(lastId: Int64, _ completion: @escaping (Result<[GithubUser], NetworkError>) -> Void) {
        let operation = BlockOperation {
            self.urlSession.dataTask(with: URL(string: "\(self.baseURL)?since=\(lastId)")!) { (data, urlResponse, error) in
                guard error == nil else {
                    completion(.failure(.badResult))
                    return
                }
                guard let data = data else {
                    completion(.failure(.badResponse))
                    return
                }
                let jsonDecoder = JSONDecoder()
                let userData = try! jsonDecoder.decode([GithubUser].self, from: data)
                    completion(.success(userData))
            }.resume()
        }
        GithubApplicationModule.operationQueue.addOperation(operation)
    }
    func fetchUser(loginKey: String, _ completion: @escaping (Result<GithubUserDetails?, NetworkError>) -> Void) {
        let operation = BlockOperation {
            self.urlSession.dataTask(with: URL(string: "\(self.baseURL)/\(loginKey)")!) { (data, urlResponse, error) in
                guard error == nil else {
                    completion(.failure(.badResult))
                    return
                }
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    let userData = try! jsonDecoder.decode(GithubUserDetails.self, from: data)
                        completion(.success(userData))
                }
            }.resume()
        }
        GithubApplicationModule.operationQueue.addOperation(operation)
    }
}
