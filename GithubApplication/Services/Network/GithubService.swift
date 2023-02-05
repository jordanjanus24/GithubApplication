//
//  GithubService.swift
//  GithubNavigation
//
//  Created by Janus Jordan on 2/2/23.
//

import Foundation


protocol GithubServiceProtocol {
    func fetchUsers(lastId: Int64, _ completion: @escaping (Result<[GithubUser], NetworkError>) -> Void)
    func fetchUser(loginKey: String, _ completion: @escaping (Result<GithubUserDetails?, NetworkError>) -> Void)
}


class GithubService: GithubServiceProtocol {
    func fetchUsers(lastId: Int64, _ completion: @escaping (Result<[GithubUser], NetworkError>) -> Void) {
        if NetworkManager.isReachable == true {
            let operation = BlockOperation {
                URLSession.shared.dataTask(with: URL(string: "https://api.github.com/users?since=\(lastId)")!) { (data, urlResponse, error) in
                    guard error == nil else {
                        completion(.failure(.badResult))
                        return
                    }
                    if let data = data {
                        let jsonDecoder = JSONDecoder()
                        let userData = try! jsonDecoder.decode([GithubUser].self, from: data)
                            completion(.success(userData))
                    }
                }.resume()
            }
            GithubApplicationModule.operationQueue.addOperation(operation)
        } else {
            let users = SavedUsersService.getAllUsers()
            completion(.success(users.map { $0.toGithubUser() }))
        }
    }
    func fetchUser(loginKey: String, _ completion: @escaping (Result<GithubUserDetails?, NetworkError>) -> Void) {
        if NetworkManager.isReachable == true {
            let operation = BlockOperation {
                URLSession.shared.dataTask(with: URL(string: "https://api.github.com/users/\(loginKey)")!) { (data, urlResponse, error) in
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
        } else {
            do {
                let users = try SavedUsersService.getEntityByLoginKey(loginKey)
                completion(.success(users?.toGithubUserDetails()))
            } catch {
                completion(.success(nil))
            }
        }
    }
}
