//
//  SavedDataServiceTests.swift
//  GithubApplicationTests
//
//  Created by Janus Jordan on 2/6/23.
//

@testable import GithubApplication
import XCTest
import CoreData

class SavedDataServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        SavedDataService.viewContext = TestCoreDataStack().persistentContainer.viewContext
        SavedDataService.backgroundContext = TestCoreDataStack().persistentContainer.newBackgroundContext()
    }
    override func tearDown() {
        super.tearDown()
        SavedDataService.viewContext = nil
        SavedDataService.backgroundContext = nil
    }
    func testGetAllUsers() throws {
        let users = SavedDataService.getAllUsers()
        XCTAssertEqual(users.count, 0)
    }
    func testSaveNote() throws {
        SavedDataService.insertSeen(id: 1)
        SavedDataService.insertNote(id: 1, note: "")
        SavedDataService.updateSeen(id: 1, seen: true)
        SavedDataService.updateNote(id: 1, note: "AAA")
    }
    
    func testUpdateNoteWithoutData() throws {
        SavedDataService.updateNote(id: 1, note: "AAA")
    }
    
    func testUpdateSeenWithoutData() throws {
        SavedDataService.updateSeen(id: 1, seen: false)
    }
    
}
