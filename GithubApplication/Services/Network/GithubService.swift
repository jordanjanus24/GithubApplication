//
//  GithubService.swift
//  GithubNavigation
//
//  Created by Janus Jordan on 2/2/23.
//

import Foundation


protocol GithubServiceProtocol {
    func fetchUsers(lastId: Int64, _ completion: @escaping ([GithubUser]) -> Void)
    func fetchUser(loginKey: String, _ completion: @escaping (GithubUserDetails?) -> Void)
}


class GithubService: GithubServiceProtocol {
    func fetchUsers(lastId: Int64, _ completion: @escaping ([GithubUser]) -> Void) {
        if NetworkManager.isReachable == true {
            let operation = BlockOperation {
                URLSession.shared.dataTask(with: URL(string: "https://api.github.com/users?since=\(lastId)")!) { (data, urlResponse, error) in
                    guard error == nil else {
                        return
                    }
                    if let data = data {
                        let jsonDecoder = JSONDecoder()
                        let userData = try! jsonDecoder.decode([GithubUser].self, from: data)
                            completion(userData)
                    }
                }.resume()
            }
            GithubApplicationModule.operationQueue.addOperation(operation)
        } else {
            let users = SavedUsersService.getAllUsers()
            completion(users.map { $0.toGithubUser() })
        }
    }
    func fetchUser(loginKey: String, _ completion: @escaping (GithubUserDetails?) -> Void) {
        if NetworkManager.isReachable == true {
            let operation = BlockOperation {
                URLSession.shared.dataTask(with: URL(string: "https://api.github.com/users/\(loginKey)")!) { (data, urlResponse, error) in
                    guard error == nil else {
                        return
                    }
                    if let data = data {
                        let jsonDecoder = JSONDecoder()
                        let userData = try! jsonDecoder.decode(GithubUserDetails.self, from: data)
                            completion(userData)
                    }
                }.resume()
            }
            GithubApplicationModule.operationQueue.addOperation(operation)
        } else {
            do {
                let users = try SavedUsersService.getEntityByLoginKey(loginKey)
                completion(users?.toGithubUserDetails())
            } catch {
                completion(nil)
            }
        }
    }
}
