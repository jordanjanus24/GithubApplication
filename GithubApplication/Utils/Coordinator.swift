//
//  Coordinator.swift
//  GithubNavigation
//
//  Created by Janus Jordan on 2/4/23.
//

import UIKit


protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    init(navigationController: UINavigationController)
    func start()
}
