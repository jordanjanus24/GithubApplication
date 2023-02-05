//
//  GithubApplicationServiceTests.swift
//  GithubApplicationTests
//
//  Created by Janus Jordan on 2/5/23.
//

@testable import GithubApplication
import XCTest

class GithubApplicationServiceTests: XCTestCase {
    var service: GithubService!
    var bundle: Bundle!
    var urlSession: URLSession = MockNetworking.init().urlSession
    var baseURL: String = "http://localhost:8080/"
    override func setUp() {
        super.setUp()
        service = GithubService()
        bundle = Bundle(for: type(of: self))
    }
    override func tearDown() {
        super.tearDown()
        service = nil
        bundle = nil
    }

    func testFetchUsers_Successful() throws {
        let data = try Data(contentsOf: bundle.url(forResource: "UsersResponse", withExtension: "json")!)
        service.baseURL = baseURL
        service.urlSession = urlSession
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url:
                                            URL(string: self.service.baseURL)!,
                                  statusCode: 200,
                                  httpVersion: nil,
                                  headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }
        let exp = expectation(description: "Waiting response expectation")
        service.fetchUsers(lastId: 0) { result in
            switch result {
                case .success(let data):
                    exp.fulfill()
                    XCTAssertGreaterThan(data.count, 0)
                    XCTAssertEqual(data[0].id, ModelsMock.DefaultUsers.user1.id)
                case .failure(_):
                    XCTFail("Unexpected failure")
            }
        }
        wait(for: [exp], timeout: 1.0)
    }
    func testFetchUsers_SuccessfulButNil() throws {
        let data = "[]".data(using: .utf8)!
        service.baseURL = baseURL
        service.urlSession = urlSession
        MockURLProtocol.error = NetworkError.badResult
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url:
                                            URL(string: self.service.baseURL)!,
                                  statusCode: 200,
                                  httpVersion: nil,
                                  headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }
        let exp = expectation(description: "Waiting response expectation")
        service.fetchUsers(lastId: 0) { result in
            switch result {
                case .success(_):
                    break
                case .failure(let error):
                    exp.fulfill()
                    XCTAssertEqual(error, .badResult)
            }
        }
        wait(for: [exp], timeout: 1.0)
    }
    func testFetchUsers_Error() throws {
        let data = try Data(contentsOf: bundle.url(forResource: "UsersResponse", withExtension: "json")!)
        service.baseURL = baseURL
        service.urlSession = urlSession
        MockURLProtocol.error = NetworkError.badResult
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url:
                                            URL(string: self.service.baseURL)!,
                                  statusCode: 304,
                                  httpVersion: nil,
                                  headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }
        let exp = expectation(description: "Waiting response expectation")
        service.fetchUsers(lastId: 0) { result in
            switch result {
                case .failure(let error):
                    exp.fulfill()
                    XCTAssertEqual(error, .badResult)
                    
                default: break
            }
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func testFetchUser_Successful() throws {
        let data = try Data(contentsOf: bundle.url(forResource: "UserResponse", withExtension: "json")!)
        service.baseURL = baseURL
        service.urlSession = urlSession
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url:
                                            URL(string: self.service.baseURL)!,
                                  statusCode: 200,
                                  httpVersion: nil,
                                  headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }
        let exp = expectation(description: "Waiting response expectation")
        service.fetchUser(loginKey: "mojombo") { result in
            switch result {
                case .success(let data):
                    XCTAssertEqual(data?.id, ModelsMock.DefaultUserDetails.user.id)
                    exp.fulfill()
                case .failure(_):
                    XCTFail("Unexpected failure")
            }
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func testFetchUser_Error() throws {
        let data = try Data(contentsOf: bundle.url(forResource: "UserResponse", withExtension: "json")!)
        service.baseURL = baseURL
        service.urlSession = urlSession
        MockURLProtocol.error = NetworkError.badResult
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url:
                                            URL(string: self.service.baseURL)!,
                                  statusCode: 304,
                                  httpVersion: nil,
                                  headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }
        let exp = expectation(description: "Waiting response expectation")
        service.fetchUser(loginKey: "mojombo") { result in
            switch result {
                case .failure(let error):
                    exp.fulfill()
                    XCTAssertEqual(error, .badResult)
                    
                default: break
            }
        }
        wait(for: [exp], timeout: 1.0)
    }
}
