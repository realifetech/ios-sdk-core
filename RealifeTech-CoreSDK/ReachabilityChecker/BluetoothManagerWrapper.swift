//
//  BluetoothManagerWrapper.swift
//  RealifeTech
//
//  Created by Olivier Butler on 03/11/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BluetoothManagable {
    var bluetoothEnabled: Bool { get }
}

class BluetoothManagerWrapper: NSObject, BluetoothManagable {

    static var bluetoothPermissionGranted: Bool {
        if #available(iOS 13.1, *) {
            return CBCentralManager.authorization == .allowedAlways
        } else {
            return CBCentralManager().authorization == .allowedAlways
        }
    }

    var bluetoothEnabled: Bool = false

    private let underlyingManager: CBCentralManager?

    override init() {
        underlyingManager = BluetoothManagerWrapper.bluetoothPermissionGranted ? CBCentralManager() : nil
        super.init()
        underlyingManager?.delegate = self
    }
}

extension BluetoothManagerWrapper: CBCentralManagerDelegate {

    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        bluetoothEnabled = central.state == .poweredOn
    }
}
