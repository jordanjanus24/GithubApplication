//
//  UsersViewModel.swift
//  GithubNavigation
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation
import Combine

protocol UsersViewModelProtocol {
    var usersPublisher: Published<[User]>.Publisher { get }
    func fetchUsers()
}

class UsersViewModel: UsersViewModelProtocol, ObservableObject {
    
    @Published internal var users: [User] = []
    var usersPublisher: Published<[User]>.Publisher { $users }
    
    private var apiManager: GithubServiceProtocol!
    private var lastRequested: Int64 = 0
    init(_ apiManager: GithubServiceProtocol) {
        self.apiManager = apiManager
        fetchUsers()
    }

    func fetchUsers() {
        var lastId: Int64 = 0
        if let lastUser = users.last {
            lastId = lastUser.id
        }
        lastRequested = lastId
        if lastRequested == lastId {
            apiManager.fetchUsers(lastId: lastId) { [weak self] (users) in
                self?.users.appendDistinct(contentsOf: users.map { $0.toUser() }, where: { $0.id != $1.id })
                SavedUsersService.saveUsers(users)
            }
        }
    }
}
