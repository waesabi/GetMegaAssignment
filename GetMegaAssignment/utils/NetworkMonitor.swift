//
//  NetworkMonitor.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import Network

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private let monitor = NWPathMonitor()
    private(set) var isReachable: Bool = false
    

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            print(path.status)
            self?.isReachable = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        print("stop monitoring")
        monitor.cancel()
    }
}
