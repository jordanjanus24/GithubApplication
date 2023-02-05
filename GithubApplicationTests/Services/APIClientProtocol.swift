//
//  APIClientProtocol.swift
//  GithubApplicationTests
//
//  Created by Janus Jordan on 2/5/23.
//

import Foundation

public protocol APIClientProtocol {
    var urlSession: URLSession { get }
    func request<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}

struct MockNetworking: APIClientProtocol {
    var urlSession: URLSession {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
    func request<T>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
    }
}
