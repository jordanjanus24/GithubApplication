//
//  TestCoreDataStack.swift
//  GithubApplicationTests
//
//  Created by Janus Jordan on 2/6/23.
//

import Foundation
import CoreData

class TestCoreDataStack: NSObject {
    
    lazy var persistentContainer: NSPersistentContainer = {
           let description = NSPersistentStoreDescription()
           description.url = URL(fileURLWithPath: "/dev/null")
           let container = NSPersistentContainer(name: "GithubApplication")
           container.persistentStoreDescriptions = [description]
           container.loadPersistentStores { _, error in
               if let error = error as NSError? {
                   fatalError("Unresolved error \(error), \(error.userInfo)")
               }
           }
           return container
       }()
    
}
