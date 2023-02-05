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
    func saveNote(_ note: String)
}

class DetailsViewModel: DetailsViewModelProtocol, ObservableObject {
    
    @Published internal var user: User? = nil {
        didSet {
            if let user = user {
                didChange.send(user.avatarUrl)
            }
        }
    }
    var didChange = PassthroughSubject<String, Never>()
    var didChangeNote = PassthroughSubject<String, Never>()
    
    private var loginKey: String!
    private var apiManager: GithubServiceProtocol!
    
    init(_ apiManager: GithubServiceProtocol, _ loginKey: String) {
        self.apiManager = apiManager
        self.loginKey = loginKey
    }
    
    func fetchUser() {
        apiManager.fetchUser(loginKey: self.loginKey) { [weak self] user in
            DispatchQueue.main.async {
                self?.user = user?.toUser()
            }
            if let user = user {
                SavedDataService.updateSeen(id: user.id, seen: true)
                SavedUsersService.updateDetails(id: user.id, githubUser: user)
                do {
                    let savedUser = try SavedDataService.getEntityById(user.id)
                    DispatchQueue.main.async {
                        self?.didChangeNote.send(savedUser?.note ?? "")
                    }
                } catch {
                    
                }
            }
        }
    }
    func saveNote(_ note: String) {
        if let user = user {
            SavedDataService.updateNote(id: user.id, note: note)
        }
    }
}
