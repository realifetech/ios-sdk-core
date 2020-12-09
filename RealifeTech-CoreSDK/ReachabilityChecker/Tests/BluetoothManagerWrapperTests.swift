//
//  BluetoothManagerWrapperTests.swift
//  RealifeTech
//
//  Created by Olivier Butler on 03/11/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
import CoreBluetooth
@testable import RealifeTech_CoreSDK

final class BluetoothManagerWrapperTests: XCTestCase {

    func test_reportsCorrectBluetoothState () {
        let sut = BluetoothManagerWrapper()
        let mockManager = MockBluetoothManager()
        sut.centralManagerDidUpdateState(mockManager)
        XCTAssertFalse(sut.bluetoothEnabled)
        mockManager.bluetoothEnabled = true
        sut.centralManagerDidUpdateState(mockManager)
        XCTAssertTrue(sut.bluetoothEnabled)
    }
}

private final class MockBluetoothManager: CBCentralManager {

    var bluetoothEnabled: Bool = false

    override var state: CBManagerState {
        return bluetoothEnabled ? .poweredOn : .poweredOff
    }
}
