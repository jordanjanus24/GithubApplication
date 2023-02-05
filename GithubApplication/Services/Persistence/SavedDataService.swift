//
//  NotesService.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/5/23.
//

import Foundation
import CoreData

class SavedDataService {
    static var viewContext: NSManagedObjectContext!
    static var backgroundContext: NSManagedObjectContext!
    
    static func getAllUsers() -> [SavedData] {
        do {
            let users = try viewContext.fetch(SavedData.fetchRequest())
            return users
        }
        catch {
            return []
        }
    }
    static func updateNote(id: Int64, note: String) {
        do {
            let user = try? getEntityById(id)
            if user != nil {
                user?.note = note
                saveContext()
            } else {
                insertNote(id: id, note: note)
            }
        } catch {
            viewContext.rollback()
        }
    }
    
    static func insertNote(id: Int64, note: String) {
        let newUser = SavedData(context: backgroundContext)
        newUser.userId = id
        newUser.seen = true
        newUser.note = note
        saveContext()
    }
    static func updateSeen(id: Int64, seen: Bool) {
        do {
            let user = try? getEntityById(id)
            if user != nil {
                user?.seen = seen
                saveContext()
            } else {
                insertSeen(id: id)
            }
        } catch {
            insertSeen(id: id)
        }
    }
    static func insertSeen(id: Int64) {
        let newUser = SavedData(context: backgroundContext)
        newUser.userId = id
        newUser.seen = true
        saveContext()
    }
    static func getEntityById(_ id: Int64)  throws  -> SavedData? {
       let request = SavedData.fetchRequest()
       request.fetchLimit = 1
       request.predicate = NSPredicate(
           format: "userId = %d", id)
        do {
            let user = try backgroundContext.fetch(request)
            if let firstUser = user.first {
                return firstUser
            } else {
               return nil
            }
        } catch {
            return nil
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
