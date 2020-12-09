//
//  DeviceRequesterTests.swift
//  RepositoriesTests
//
//  Created by Olivier Butler on 13/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class DeviceRequesterTests: XCTestCase {

    private let sut = DeviceRequester.self

    func test_registerDevice() {
        let testDevice = Device(deviceId: "123",
                                model: "model1",
                                sdkVersion: "1.2.3",
                                osVersion: "10.301",
                                bluetoothOn: false,
                                wifiConnected: true)
        let requestToTest = sut.register(device: testDevice)
        XCTAssertEqual(requestToTest.url?.path, "/device/register")
        guard
            let data = requestToTest.httpBody,
            let jsonObject = try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments) as? [String: Any]
            else {
                return XCTFail("No http body")
        }
        XCTAssertEqual(jsonObject["appVersion"] as? String, testDevice.appVersion)
    }

    func test_registerForPushNotifications() {
        let testTokenString = "Test_TOKEN"
        let testToken = DeviceToken.defaultDeviceToken(withProviderToken: testTokenString)
        let requestToTest = sut.register(tokenForPushNotificationsWithDeviceToken: testToken)
        XCTAssertEqual(requestToTest.url?.path, "/device/me/token")
        guard
            let data = requestToTest.httpBody,
            let jsonObject = try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments) as? [String: Any]
            else {
                return XCTFail("No http body")
        }
        XCTAssertEqual(jsonObject["providerToken"] as? String, testTokenString)
    }
}
