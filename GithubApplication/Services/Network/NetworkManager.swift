//
//  ReachabilityService.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/5/23.
//

import Foundation
import Reachability

enum NetworkError: Error {
    case badResult, badResponse
}

class NetworkManager: NSObject {
    var reachability: Reachability!
    var networkCallback: (Bool) -> Void = { _ in }
    var isReachable: Bool = false
    
    func start() {
        do {
            self.reachability = try Reachability()
            if reachability.connection != .unavailable {
                self.isReachable = true
            }
            NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
            try self.reachability.startNotifier()
        } catch {
            
        }
    }
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
            case .wifi, .cellular:
                self.isReachable = true
            case .none, .unavailable:
                self.isReachable = false
        }
        self.networkCallback(self.isReachable)
    }
    func stop() {
        if reachability != nil {
            self.reachability.stopNotifier()
            NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
        }
    }
}

