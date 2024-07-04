//
//  AppCommon.swift
//  Yummie
//
//  Created by husayn on 03/07/2024.
//

import Foundation
import Reachability

class AppCommon{
    
    public static let shared = AppCommon()

    private let reachability = try! Reachability()

    private init() {
        startMonitoring()
    }

    private func startMonitoring() {
        reachability.whenReachable = { _ in
            print("Network is reachable")
        }
        reachability.whenUnreachable = { _ in
            print("No Network!!")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    func isNetworkReachable() -> Bool {
        return reachability.connection != .unavailable
    }
    
}
    
