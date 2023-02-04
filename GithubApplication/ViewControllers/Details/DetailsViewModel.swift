//
//  DetailsViewModel.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation
import Combine

protocol DetailsViewModelProtocol {
    func fetchUser()
}

class DetailsViewModel: DetailsViewModelProtocol, ObservableObject {
    
    @Published internal var user: User? = nil
    
    private var loginKey: String!
    private var apiManager: GithubServiceProtocol!
    
    init(_ apiManager: GithubServiceProtocol, _ loginKey: String) {
        self.apiManager = apiManager
        self.loginKey = loginKey
    }
    
    func fetchUser() {
        apiManager.fetchUser(loginKey: self.loginKey) { [weak self] user in
            self?.user = user?.toUser()
            SavedUsersService.updateDetails(id: user?.id, githubUser: user)
        }
    }
}
