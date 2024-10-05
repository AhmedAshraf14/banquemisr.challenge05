//
//  Connectivity.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 05/10/2024.
//

import Foundation
import Network

protocol ConnectivityProtocol {
    func checkConnectivity(completion: @escaping(Bool)->())
}

class Connectivity: ConnectivityProtocol {
    static let shared = Connectivity()
    private init() {}
    
    func checkConnectivity(completion: @escaping(Bool)->()) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            let status = path.status == .satisfied
            DispatchQueue.main.async {
                completion(status)
            }
            monitor.cancel()
        }
        monitor.start(queue: .main)
    }
}
