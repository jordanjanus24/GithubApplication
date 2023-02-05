//
//  AppDelegate.swift
//  GithubNavigation
//
//  Created by Janus Jordan on 2/2/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var coordinator: GithubApplicationCoordinator?
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SavedUsersService.viewContext = persistentContainer.viewContext
        SavedUsersService.backgroundContext = persistentContainer.newBackgroundContext()
        SavedDataService.viewContext = persistentContainer.viewContext
        SavedDataService.backgroundContext = persistentContainer.newBackgroundContext()
        NetworkManager.sharedInstance.start()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    func applicationWillTerminate(_ application: UIApplication) {
        SavedUsersService.saveContext()
        NetworkManager.sharedInstance.stop()
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GithubApplication")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


}

