//
//  UsersViewModel.swift
//  GithubNavigation
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation
import Combine

protocol UsersViewModelProtocol {
    var lastRequested: Int64 { get set }
    var usersPublisher: Published<[User]>.Publisher { get }
    func fetchUsers()
}

class UsersViewModel: UsersViewModelProtocol, ObservableObject {
    
    @Published internal var users: [User] = []
    var usersPublisher: Published<[User]>.Publisher { $users }
    
    private var apiManager: GithubServiceProtocol!
    var lastRequested: Int64 = 0
    init(_ apiManager: GithubServiceProtocol) {
        self.apiManager = apiManager
    }

    func fetchUsers() {
        var lastId: Int64 = 0
        if let lastUser = users.last {
            lastId = lastUser.id
        }
        if lastRequested == 0 {
           reprocessUsersFromData()
        }
        lastRequested = lastId
        if lastRequested == lastId {
            apiManager.fetchUsers(lastId: lastId) { [weak self] result in
                switch result {
                    case .success(let users):
                        let savedData = SavedDataService.getAllUsers()
                        let insertingUsers = users.map { user -> (User) in
                            var savedUser = user.toUser()
                            let data = savedData.filter { $0.userId == user.id }
                            if let data = data.first {
                                savedUser.note = data.note ?? ""
                                savedUser.seen = data.seen
                            }
                            return savedUser
                        }
                        self?.users.appendDistinct(contentsOf: insertingUsers, where: { $0.id != $1.id })
                        SavedUsersService.saveUsers(users)
                    case .failure(_):
                        print("ERRR")
                }
               
            }
        }
    }
    private func reprocessUsersFromData() {
        let savedData = SavedDataService.getAllUsers()
        let latestUserDatas = self.users.map { user -> (User) in
            var savedUser = user
            let data = savedData.filter { $0.userId == user.id }
            if let data = data.first {
                savedUser.note = data.note ?? ""
                savedUser.seen = data.seen
            }
            return savedUser
        }
        self.users = latestUserDatas
    }
}
