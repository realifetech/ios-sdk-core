//
//  APIRequesterHelperTests.swift
//  APIUtilitiesTests
//
//  Created by Olivier Butler on 08/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class APIRequesterHelperTests: XCTestCase {

    let testDeviceId = "device123"
    let testClientId = "client456"
    let testClientSecret = "secret789"
    let testBaseUrl = "baseUrl123"
    var tokenManager: APITokenManagable?

    override func setUp() {
        tokenManager = APIRequesterHelper.setupAPI(
            deviceId: testDeviceId,
            clientId: testClientId,
            clientSecret: testClientSecret,
            baseUrl: testBaseUrl)
    }

    func test_setupAPI_staticProperties() {
        XCTAssertNotNil(tokenManager)
        XCTAssertNotNil(APIRequesterHelper.tokenManager)
        XCTAssertTrue(APIRequesterHelper.tokenManager is APITokenManager)
        XCTAssertEqual(testDeviceId, APIRequesterHelper.deviceId)
        XCTAssertEqual(testBaseUrl, APIRequesterHelper.baseUrl)
    }

    func test_setupAPI_oAuthParameters() {
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
