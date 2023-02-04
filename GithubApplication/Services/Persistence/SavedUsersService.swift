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
    static var context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
            let users = try context.fetch(SavedUser.fetchRequest())
            return users
        }
        catch {
            return []
        }
    }
    static func createUser(githubUser: GithubUser) {
        var user = githubUser
        let newUser = SavedUser(context: context)
        user.mapToSavedUser(savedUser: newUser)
        saveContext()
    }
    static func deleteItem(item: SavedUser) {
        context.delete(item)
        saveContext()
    }
    static func updateNote(id: Int64, note: String) {
        do {
            let user = try getEntityById(id)!
            user.note = note
            saveContext()
        } catch {
            context.rollback()
        }
        
    }
    static func getEntityById(_ id: Int64)  throws  -> SavedUser?{
       let request = SavedUser.fetchRequest()
       request.fetchLimit = 1
       request.predicate = NSPredicate(
           format: "id = %d", id)
       let user = try context.fetch(request)[0]
       return user
    }
    
    private static func isExistingEntity(_ id: Int64)  throws  -> Bool{
       let request = SavedUser.fetchRequest()
       request.fetchLimit = 1
       request.predicate = NSPredicate(
           format: "id = %d", id)
        do {
            let users = try context.fetch(request)
            return users.count >= 1
        } catch {
            return false
        }
    }
    private static func saveContext(){
        if context.hasChanges {
            do {
                try context.save()
            } catch{
                context.rollback()
            }
        }
    }
}
