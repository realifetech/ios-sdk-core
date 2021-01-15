//
//  ReachabilityCheckerTests.swift
//  ReachabilityCheckerTests
//
//  Created by Realife Tech on 24/09/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
import CoreBluetooth
@testable import RealifeTech_CoreSDK

final class ReachabilityCheckerTests: XCTestCase {

    func test_bluetooth_enabled() {
        let mockBluetoothManager = MockBluetoothManager()
        mockBluetoothManager.bluetoothEnabled = true
        let sut = ReachabilityChecker(bluetoothManager: mockBluetoothManager)
        XCTAssertTrue(sut.isBluetoothConnected)
    }

    func test_bluetooth_disabled() {
        let mockBluetoothManager = MockBluetoothManager()
        let sut = ReachabilityChecker(bluetoothManager: mockBluetoothManager)
        XCTAssertFalse(sut.isBluetoothConnected)
    }

    func test_wifi_connected() {
        let mockHelper = MockWifiConnectivityChecker()
        mockHelper.wifiEnabled = true
        let sut = ReachabilityChecker(
            bluetoothManager: MockBluetoothManager(),
            networkConnectivityChecker: mockHelper)
        XCTAssertTrue(sut.isConnectedToWifi)
    }

    func test_wifi_notConnected() {
        let mockHelper = MockWifiConnectivityChecker()
        let sut = ReachabilityChecker(
            bluetoothManager: MockBluetoothManager(),
            networkConnectivityChecker: mockHelper)
        XCTAssertFalse(sut.isConnectedToWifi)
    }

    private final class MockBluetoothManager: BluetoothManagable {

        var bluetoothEnabled: Bool = false
    }

    private final class MockWifiConnectivityChecker: NetworkConnectivityChecker {

        var wifiEnabled: Bool = false

        override var wifiConnected: Bool {
            return wifiEnabled
        }
    }
}
