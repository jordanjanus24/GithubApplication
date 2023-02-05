//
//  ReachabilityService.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/5/23.
//

import Foundation
import Reachability

class NetworkManager: NSObject {
    var reachability: Reachability!
    static let sharedInstance: NetworkManager = {
        return NetworkManager()
    }()
    static var networkCallback: (Bool) -> Void = { _ in }
    static var isReachable: Bool = false
    
    func start() {
        do {
            self.reachability = try Reachability()
            if reachability.connection != .unavailable {
                NetworkManager.isReachable = true
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
                NetworkManager.isReachable = true
            case .none, .unavailable:
                NetworkManager.isReachable = false
        }
        NetworkManager.networkCallback(NetworkManager.isReachable)
    }
    func stop() {
        self.reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}

