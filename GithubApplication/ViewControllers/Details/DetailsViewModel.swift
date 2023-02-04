//
//  DetailsViewModel.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation
import Combine

protocol DetailsViewModelProtocol {
    var userPublisher: Published<User?>.Publisher { get }
    func fetchUser(_ id: Int64)
}

class DetailsViewModel: DetailsViewModelProtocol, ObservableObject {
    
    @Published internal var user: User? = nil
    var userPublisher: Published<User?>.Publisher { $user }
    
    private var apiManager: GithubServiceProtocol!
    
    init(_ apiManager: GithubServiceProtocol) {
        self.apiManager = apiManager
    }
    
    func fetchUser(_ id: Int64) {
        
    }
}
