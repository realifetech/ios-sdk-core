//
//  APIV3RequesterHelperTests.swift
//  APIV3UtilitiesTests
//
//  Created by Olivier Butler on 08/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class APIV3RequesterHelperTests: XCTestCase {

    let testDeviceId = "device123"
    let testClientId = "client456"
    let testClientSecret = "secret789"
    let testBaseUrl = "baseUrl123"
    var tokenManager: V3APITokenManagable?

    override func setUp() {
        tokenManager = APIV3RequesterHelper.setupV3API(
            deviceId: testDeviceId,
            clientId: testClientId,
            clientSecret: testClientSecret,
            baseUrl: testBaseUrl)
    }

    func test_setupV3API_staticProperties() {
        XCTAssertNotNil(tokenManager)
        XCTAssertNotNil(APIV3RequesterHelper.tokenManager)
        XCTAssertTrue(APIV3RequesterHelper.tokenManager is V3APITokenManager)
        XCTAssertEqual(testDeviceId, APIV3RequesterHelper.deviceId)
        XCTAssertEqual(testBaseUrl, APIV3RequesterHelper.v3baseUrl.rawValue)
    }

    func test_setupV3API_oAuthParameters() {
        let requestToTest = OAuthRequester.requestInitialAccessToken()
        XCTAssertTrue(requestToTest.url?.absoluteString.contains(testBaseUrl) ?? false)
        guard
            let bodyData = requestToTest.httpBody,
            let bodyDict = try? JSONSerialization.jsonObject(
                with: bodyData,
                options: .allowFragments) as? NSDictionary
            else {
                return XCTFail("No body data")
        }
        let resultClientId = bodyDict["client_id"] as? String
        let resultClientSecret = bodyDict["client_secret"] as? String
        XCTAssertEqual(resultClientId, testClientId + "_0")
        XCTAssertEqual(resultClientSecret, testClientSecret)
        return
    }
}
