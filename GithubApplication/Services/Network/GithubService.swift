//
//  GithubService.swift
//  GithubNavigation
//
//  Created by Janus Jordan on 2/2/23.
//

import Foundation



class GithubService {
    func fetchUsers(lastId: Int64, _ completion: @escaping ([GithubUser]) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "https://api.github.com/users?since=\(lastId)")!) { (data, urlResponse, error) in
            guard error == nil else {
                return
            }
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let empData = try! jsonDecoder.decode([GithubUser].self, from: data)
                    completion(empData)
            }
        }.resume()
    }
}
