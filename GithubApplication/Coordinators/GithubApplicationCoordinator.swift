//
//  GithubNavigationCoordinator.swift
//  GithubNavigation
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation
import UIKit
import CoreData

protocol GithubApplicationCoordinatorProtocol {
    func start()
    func showDetails(_ id: Int64)
}

public class GithubApplicationCoordinator: NSObject, Coordinator, GithubApplicationCoordinatorProtocol {
    
    lazy var applicationModule = GithubApplicationModule(coordinator: self)
    
    internal var childCoordinators = [Coordinator]()
    internal var navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
    public func start() {
        applicationModule.startInitialFlow(self.navigationController)
    }
    public func showDetails(_ id: Int64) {
        applicationModule.showDetailsView(self.navigationController)
    }
}

extension GithubApplicationCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if self.navigationController.viewControllers.count == 1 {
            self.navigationController.navigationBar.prefersLargeTitles = true
        } else {
            self.navigationController.navigationBar.prefersLargeTitles = false
        }
    }
}
