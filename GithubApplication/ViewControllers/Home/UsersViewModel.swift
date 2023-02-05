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
    func fetchInitialUsers()
    func fetchUsers(from lastId: Int64)
    func setDataFromCache()
}

class UsersViewModel: UsersViewModelProtocol, ObservableObject {
    
    @Published internal var users: [User] = []
    var usersPublisher: Published<[User]>.Publisher { $users }
    
    private var apiManager: GithubServiceProtocol!
    init(_ apiManager: GithubServiceProtocol) {
        self.apiManager = apiManager
    }

    func fetchInitialUsers() {
        self.users = []
        fetchUsers(from: 0)
    }
    func setDataFromCache() {
        let users = SavedUsersService.getAllUsers()
        self.users = users.map { $0.toUser() }
        self.setupUsersFromData(users: self.users, append: false)
    }
    func fetchUsers(from lastId: Int64) {
        apiManager.fetchUsers(lastId: lastId) { [weak self] result in
            switch result {
                case .success(let users):
                    self?.setupUsersFromData(users: users.map { $0.toUser()}, append: true)
                    SavedUsersService.saveUsers(users)
                case .failure(_):
                    self?.setDataFromCache()
            }
        }
    }
    private func setupUsersFromData(users: [User], append: Bool = false) {
        let savedData = SavedDataService.getAllUsers()
        let latestUserDatas = users.map { user -> (User) in
            var savedUser = user
            let data = savedData.filter { $0.userId == user.id }
            if let data = data.first {
                savedUser.note = data.note ?? ""
                savedUser.seen = data.seen
            }
            return savedUser
        }
        if append == true {
            self.users.appendDistinct(contentsOf: latestUserDatas, where: { $0.id != $1.id })
        } else {
            self.users = latestUserDatas
        }
    }
}
