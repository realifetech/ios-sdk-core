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

    private let testDeviceId = "device123"
    private let testClientId = "client456"
    private let testClientSecret = "secret789"
    private let testBaseUrl = "baseUrl123"
    private var tokenManager: APITokenManagable?

    override func setUp() {
        super.setUp()
        tokenManager = APIRequesterHelper.setupAPI(
            deviceId: testDeviceId,
            clientId: testClientId,
            clientSecret: testClientSecret,
            baseUrl: testBaseUrl)
    }

    override func tearDown() {
        tokenManager = nil
        super.tearDown()
    }

    func test_setupAPI_staticProperties() {
        XCTAssertNotNil(tokenManager)
        XCTAssertNotNil(APIRequesterHelper.tokenManager)
        XCTAssertTrue(APIRequesterHelper.tokenManager is APITokenManager)
        XCTAssertEqual(testDeviceId, APIRequesterHelper.deviceId)
        XCTAssertEqual(testBaseUrl, APIRequesterHelper.baseUrl)
    }

    func test_setupAPI_oAuthParameters() throws {
        let requestToTest = OAuthRequester.requestInitialAccessToken()
        XCTAssertTrue(requestToTest.url?.absoluteString.contains(testBaseUrl) ?? false)
        let bodyData = try XCTUnwrap(requestToTest.httpBody)
        let bodyDict = try XCTUnwrap(
            JSONSerialization.jsonObject(
                with: bodyData,
                options: .allowFragments) as? NSDictionary)
        let resultClientId = bodyDict["client_id"] as? String
        let resultClientSecret = bodyDict["client_secret"] as? String
        XCTAssertEqual(resultClientId, testClientId + "_0")
        XCTAssertEqual(resultClientSecret, testClientSecret)
        return
    }
}
