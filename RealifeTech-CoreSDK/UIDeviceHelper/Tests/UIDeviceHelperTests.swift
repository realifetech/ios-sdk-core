//
//  UIDeviceHelperTests.swift
//  UIDeviceHelperTests
//
//  Created by Realife Tech on 24/09/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class UIDeviceHelperTests: XCTestCase {

    func test_deviceUUID() {
        let mockDevice = MockDevice()
        let sut = UIDeviceFactory.makeUIDeviceHelper(device: mockDevice)
        XCTAssertEqual(sut.deviceId, "00000000-4321-1234-4321-000000000000")
    }

    func test_deviceModel() {
        let mockDevice = MockDevice()
        let sut = UIDeviceFactory.makeUIDeviceHelper(device: mockDevice)
        XCTAssertEqual(sut.model, "iPhone")
    }

    func test_deviceSystemVersion() {
        let mockDevice = MockDevice()
        let sut = UIDeviceFactory.makeUIDeviceHelper(device: mockDevice)
        XCTAssertEqual(sut.osVersion, "14.0")
    }

    private final class MockDevice: UIDevice {

        override class var current: UIDevice {
            return MockDevice()
        }

        override var identifierForVendor: UUID? {
            return UUID(uuidString: "00000000-4321-1234-4321-000000000000")
        }

        override var model: String {
            return "iPhone"
        }

        override var systemVersion: String {
            return "14.0"
        }
    }
}
