//
//  ReachabilityChecker.swift
//  ReachabilityChecker
//
//  Created by Jonathon Albert on 24/09/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

class ReachabilityChecker: NSObject {

    private var bluetoothManager: BluetoothManagable
    private var networkConnectivityChecker: NetworkConnectivityChecker

    init(
        bluetoothManager: BluetoothManagable,
        networkConnectivityChecker: NetworkConnectivityChecker = NetworkConnectivityChecker()
    ) {
        self.bluetoothManager = bluetoothManager
        self.networkConnectivityChecker = networkConnectivityChecker
        super.init()
    }
}

extension ReachabilityChecker: ReachabilityChecking {

    public var isBluetoothConnected: Bool {
        return bluetoothManager.bluetoothEnabled
    }

    public var isConnectedToWifi: Bool {
        return networkConnectivityChecker.wifiConnected
    }

    public var hasNetworkConnection: Bool {
        return networkConnectivityChecker.hasNetworkConnection
    }
}
