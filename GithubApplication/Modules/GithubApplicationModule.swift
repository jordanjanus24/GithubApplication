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
    
    static var operationQueue = OperationQueue()
    static var cache = NSCache<NSString, AnyObject>()
    
    lazy var apiService: GithubServiceProtocol = GithubService()
    lazy var usersViewModel: UsersViewModelProtocol = UsersViewModel(apiService)
    lazy var detailsViewModel: DetailsViewModelProtocol = DetailsViewModel(apiService)
    
    lazy var moduleData: GithubApplicationModuleData = GithubApplicationModuleData(githubService: apiService)
    lazy var viewModels: GithubApplicationViewModels = GithubApplicationViewModels(usersViewModel: usersViewModel, detailsViewModel: detailsViewModel)
    
    private var coordinator: GithubApplicationCoordinatorProtocol!
    
    init(coordinator: GithubApplicationCoordinatorProtocol) {
        self.coordinator = coordinator
        GithubApplicationModule.operationQueue.maxConcurrentOperationCount = 1
    }
    
    func startInitialFlow(_ navController: UINavigationController) {
        let vc = HomeViewController.instantiate(GithubApplicationModule.storyboardId)
        vc.viewModel = viewModels.usersViewModel
        vc.coordinator = coordinator
        navController.pushViewController(vc, animated: false)
    }
    func showDetailsView(_ navController: UINavigationController) {
        let vc = DetailsViewController.instantiate(GithubApplicationModule.storyboardId)
        vc.viewModel = viewModels.detailsViewModel
        navController.pushViewController(vc, animated: true)
    }
}

struct GithubApplicationModuleData {
    let githubService: GithubServiceProtocol
}
struct GithubApplicationViewModels {
    let usersViewModel: UsersViewModelProtocol
    let detailsViewModel: DetailsViewModelProtocol
}
