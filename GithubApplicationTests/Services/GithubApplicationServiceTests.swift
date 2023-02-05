//
//  GithubApplicationServiceTests.swift
//  GithubApplicationTests
//
//  Created by Janus Jordan on 2/5/23.
//

@testable import GithubApplication
import XCTest

class GithubServiceSpy: GithubServiceProtocol {
    
    var fetchUsersCalled = false
    func fetchUsers(lastId: Int64, _ completion: @escaping (Result<[GithubUser], NetworkError>) -> Void) {
        fetchUsersCalled = true
    }
    
    var fetchUserCalled = false
    func fetchUser(loginKey: String, _ completion: @escaping (Result<GithubUserDetails?, NetworkError>) -> Void) {
        fetchUsersCalled = true
    }
}

class GithubApplicationServiceTests: XCTestCase {
    var service: GithubService!
    override func setUp() {
        super.setUp()
        service = GithubService()
    }
    override func tearDown() {
        super.tearDown()
    }

    func testExample() throws {
        let spy = GithubServiceSpy()
    }
}
