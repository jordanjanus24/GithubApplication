//
//  SceneDelegate.swift
//  GithubNavigation
//
//  Created by Janus Jordan on 2/2/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var coordinator: GithubApplicationCoordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = (scene as? UIWindowScene) {
            window = UIWindow(windowScene: windowScene)
            coordinator = GithubApplicationCoordinator(navigationController: UINavigationController())
            coordinator?.start()
            window?.rootViewController = coordinator?.navigationController
            window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

