//
//  SavedUsersService.swift
//  GithubNavigation
//
//  Created by Janus Jordan on 2/3/23.
//

import Foundation
import UIKit
import CoreData

class SavedUsersService {
    static var viewContext: NSManagedObjectContext!
    static var backgroundContext: NSManagedObjectContext!
    static func saveUsers(_ users: [GithubUser]) {
        users.forEach { user in
            do {
                let isExisting = try isExistingEntity(user.id)
                if isExisting == false {
                    self.createUser(githubUser: user)
                }
            } catch {
            }
        }
        saveContext()
    }
    static func getAllUsers() -> [SavedUser] {
        do {
            let users = try viewContext.fetch(SavedUser.fetchRequest())
            return users
        }
        catch {
            return []
        }
    }
    static func createUser(githubUser: GithubUser) {
        var user = githubUser
        let newUser = SavedUser(context: backgroundContext)
        user.mapToSavedUser(savedUser: newUser)
        saveContext()
    }
    static func updateDetails(id: Int64, githubUser: GithubUserDetails) {
        do {
            var user = githubUser
            let editingUser = try getEntityById(id)!
            user.mapToSavedUser(savedUser: editingUser)
            saveContext()
        } catch {
            viewContext.rollback()
        }
    }
    static func getEntityById(_ id: Int64)  throws  -> SavedUser?{
       let request = SavedUser.fetchRequest()
       request.fetchLimit = 1
       request.predicate = NSPredicate(
           format: "id = %d", id)
       let user = try backgroundContext.fetch(request)[0]
       return user
    }
    
    static func getEntityByLoginKey(_ loginKey: String)  throws  -> SavedUser?{
       let request = SavedUser.fetchRequest()
       request.fetchLimit = 1
       request.predicate = NSPredicate(
           format: "login = %@", loginKey)
        do {
            let user = try viewContext.fetch(request)
            return user[0]
        } catch {
            return nil
        }
    }
    
    private static func isExistingEntity(_ id: Int64)  throws  -> Bool{
       let request = SavedUser.fetchRequest()
       request.fetchLimit = 1
       request.predicate = NSPredicate(
           format: "id = %d", id)
        do {
            let users = try backgroundContext.fetch(request)
            return users.count >= 1
        } catch {
            return false
        }
    }
    static func saveContext(){
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch{
                viewContext.rollback()
            }
        }
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch{
                backgroundContext.rollback()
            }
        }
    }
}
