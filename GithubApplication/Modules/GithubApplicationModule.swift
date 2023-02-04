//
//  GithubNavigatorModule.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation
import CoreData
import UIKit

class GithubApplicationModule {
    
    static var storyboardId: String = "Main"
    
    
    lazy var apiService: GithubService = GithubService()
    lazy var usersViewModel: UsersViewModelProtocol = UsersViewModel(apiService)
    
    lazy var moduleData: GithubApplicationModuleData = GithubApplicationModuleData(githubService: apiService)
    lazy var viewModels: GithubApplicationViewModels = GithubApplicationViewModels(usersViewModel: usersViewModel)
    
    private var coordinator: GithubApplicationCoordinatorProtocol!
    
    init(coordinator: GithubApplicationCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func startInitialFlow(_ navController: UINavigationController) {
        let vc = HomeViewController.instantiate(GithubApplicationModule.storyboardId)
        vc.viewModel = viewModels.usersViewModel
        vc.coordinator = coordinator
        navController.pushViewController(vc, animated: false)
    }
    func showDetailsView(_ navController: UINavigationController) {
        let vc = DetailsViewController.instantiate(GithubApplicationModule.storyboardId)
        navController.pushViewController(vc, animated: true)
    }
}

struct GithubApplicationModuleData {
    let githubService: GithubService
}
struct GithubApplicationViewModels {
    let usersViewModel: UsersViewModelProtocol
}
