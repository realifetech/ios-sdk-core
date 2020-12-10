//
//  ReachabilityChecking.swift
//  ReachabilityChecker
//
//  Created by Jonathon Albert on 24/09/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public protocol ReachabilityChecking {
    var isBluetoothConnected: Bool { get }
    var isConnectedToWifi: Bool { get }
    var hasNetworkConnection: Bool { get }
}
