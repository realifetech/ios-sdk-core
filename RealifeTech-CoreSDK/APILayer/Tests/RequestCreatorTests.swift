//
//  RequestCreatorTests.swift
//  CLArenaTests
//
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class RequestCreatorTests: XCTestCase {

    func test_getParametersWithArray() {
        let testBody = ["userActions[]": ["scheduled", "interested", "going"]]
        let getParameters = RequestCreator.addGETParameters(fromBody: testBody)
        XCTAssertEqual(getParameters, "?userActions[]=scheduled&userActions[]=interested&userActions[]=going&")
    }

    func test_getSingleParameters() {
        let testBody = ["forceApiCheck": 1]
        let getParameters = RequestCreator.addGETParameters(fromBody: testBody)
        XCTAssertEqual(getParameters, "?forceApiCheck=1&")
    }

    func test_getMultipleParameters() {
        let testBody: [String: Any] = ["forceApiCheck": 1, "pageSize": 50, "testParameter": "test"]
        let getParameters = RequestCreator.addGETParameters(fromBody: testBody)
        XCTAssertTrue(getParameters.contains("forceApiCheck=1"))
        XCTAssertTrue(getParameters.contains("pageSize=50"))
        XCTAssertTrue(getParameters.contains("testParameter=test"))
    }

    func test_getMultipleParametersDifferentOrder() {
        let userActions = ["scheduled", "going", "calendar", "interested"]
        let testBody1: [String: Any] = [
            "forceApiCheck": 1,
            "pageSize": 50,
            "testParameter": "test",
            "userActions[]": userActions]
        let testBody2: [String: Any] = [
            "pageSize": 50,
            "forceApiCheck": 1,
            "testParameter": "test",
            "userActions[]": userActions]
        XCTAssertEqual(
            RequestCreator.addGETParameters(fromBody: testBody1),
            RequestCreator.addGETParameters(fromBody: testBody2))
    }
}
