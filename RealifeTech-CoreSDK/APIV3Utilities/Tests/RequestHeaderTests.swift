//
//  RequestHeaderTests.swift
//  General
//
//  Created by Olivier Butler on 07/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class RequestHeaderTests: XCTestCase {

    func test_generateDeviceIdHeader() {
        let testId = "123"
        let sut = RequestHeader.generateDeviceIdHeader(deviceId: testId)
        XCTAssertEqual(sut.header, "X-Ls-DeviceId")
        XCTAssertEqual(sut.valueForHeader, testId)
    }

    func test_generateAuthHeader() {
        let testToken = "456"
        let sut = RequestHeader.generateAuthHeader(accessToken: testToken)
        XCTAssertEqual(sut.header, "Authorization")
        XCTAssertEqual(sut.valueForHeader, "Bearer \(testToken)")
    }

}
