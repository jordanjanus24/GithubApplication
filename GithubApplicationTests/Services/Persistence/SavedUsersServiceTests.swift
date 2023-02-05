//
//  SavedUsersServiceTests.swift
//  GithubApplicationTests
//
//  Created by Janus Jordan on 2/6/23.
//

@testable import GithubApplication
import XCTest
import CoreData

class SavedUsersServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        SavedUsersService.viewContext = TestCoreDataStack().persistentContainer.viewContext
        SavedUsersService.backgroundContext = TestCoreDataStack().persistentContainer.newBackgroundContext()
    }
    override func tearDown() {
        super.tearDown()
        SavedUsersService.viewContext = nil
        SavedUsersService.backgroundContext = nil
    }
    
    func testGetAllUsers() throws {
        let users = SavedUsersService.getAllUsers()
        XCTAssertEqual(users.count, 0)
    }
    func testSaveUsers() throws {
        let context = SavedUsersService.viewContext
        SavedUsersService.saveUsers(ModelsMock.DefaultUsers.users)
        try! context?.save()
    }
    
    func testSaveDetails() throws {
        SavedUsersService.createUser(githubUser: ModelsMock.DefaultUsers.user1)
        SavedUsersService.updateDetails(id: 1, githubUser: ModelsMock.DefaultUserDetails.user)
    }
    
}
