//
//  RepositoriesTests.swift
//  DeviceTests
//
//  Created by Olivier Butler on 09/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class DeviceTests: XCTestCase {

    private static let jsonDevice: [String: Any] = [
        "appVersion": "0.0.1alpha",
        "manufacturer": "APPLE",
        "osVersion": "4",
        "model": "OlivierPhone",
        "wifiConnected": true,
        "bluetoothOn": false,
        "type": "IOS",
        "token": "123"
    ]

    private static let testDevice: Device = Device(
        deviceId: "123",
        type: "IOS",
        model: "OlivierPhone",
        manufacturer: "APPLE",
        sdkVersion: "0.0.1alpha",
        osVersion: "4",
        bluetoothOn: false,
        wifiConnected: true)

    func test_jsonRepresentation() {
        let sutDict = DeviceTests.testDevice.jsonRepresentation
        XCTAssertEqual(sutDict.count, DeviceTests.jsonDevice.count)
        sutDict.enumerated().forEach { (_, elementTuple) in
            let (key, value) = elementTuple
            if let isBool = value as? Bool {
                XCTAssertEqual(isBool, DeviceTests.jsonDevice[key] as? Bool)
            } else if let isString = value as? String {
                XCTAssertEqual(isString, DeviceTests.jsonDevice[key] as? String)
            } else {
                XCTFail("Unexpected device value")
            }
        }
    }
}
