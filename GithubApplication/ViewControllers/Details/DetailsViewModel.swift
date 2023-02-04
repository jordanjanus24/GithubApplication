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
    func fetchUser()
}

class DetailsViewModel: DetailsViewModelProtocol, ObservableObject {
    
    @Published internal var user: User? = nil
    var userPublisher: Published<User?>.Publisher { $user }
    func fetchUser() {
        
    }
}
