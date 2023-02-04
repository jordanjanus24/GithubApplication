//
//  GithubService.swift
//  GithubNavigation
//
//  Created by Janus Jordan on 2/2/23.
//

import Foundation


protocol GithubServiceProtocol {
    func fetchUsers(lastId: Int64, _ completion: @escaping ([GithubUser]) -> Void)
    func fetchUser(id: Int64, _ completion: @escaping (GithubUser) -> Void)
}


class GithubService: GithubServiceProtocol {
    func fetchUsers(lastId: Int64, _ completion: @escaping ([GithubUser]) -> Void) {
        Reachability.isConnectedToNetwork { isConnected in
            if isConnected == true {
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
    }
    func fetchUser(id: Int64, _ completion: @escaping (GithubUser) -> Void) {
        
    }
}
