//
//  APIErrorTests.swift
//  APILayerTests
//
//  Created by JAlbert on 24/10/2019.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class APIErrorTests: XCTestCase {

    let errorData = ["error": "invalid_grant", "error_description": "The access token provided has expired."]
    let mockError = MockAPIError.genericError()

    func test_constructedError_from_ValidData() throws {
        let basicErrorData = try JSONEncoder().encode(errorData)
        let constructedError = APIError.constructedError(data: basicErrorData)
        XCTAssertEqual(constructedError.message, "The access token provided has expired.")
    }

    func test_constructedError_from_InvalidData() throws {
        let errorData = "{\"error\":\"invalid_grant\",\"error_description\":\"The access token provided has expired.\"}"
        let basicErrorData = try JSONEncoder().encode(errorData)
        let constructedError = APIError.constructedError(data: basicErrorData)
        XCTAssertEqual(constructedError.message, "UNPARSEABLE_ERROR")
    }

    func test_badRequest() throws {
        let basicErrorData = try JSONEncoder().encode(errorData)
        let constructedError = APIError.constructedError(data: basicErrorData, statusCode: 400)
        XCTAssertTrue(constructedError.badRequest)
        XCTAssertTrue(constructedError.clientError)
        XCTAssertFalse(constructedError.logicError)
        XCTAssertFalse(constructedError.unAuthenticated)
    }

    func test_clientError() throws {
        let basicErrorData = try JSONEncoder().encode(errorData)
        let constructedError = APIError.constructedError(data: basicErrorData, statusCode: 450)
        XCTAssertFalse(constructedError.badRequest)
        XCTAssertTrue(constructedError.clientError)
        XCTAssertFalse(constructedError.logicError)
        XCTAssertFalse(constructedError.unAuthenticated)
    }

    func test_falseClientError() throws {
        let basicErrorData = try JSONEncoder().encode(errorData)
        let constructedError = APIError.constructedError(data: basicErrorData)
        XCTAssertFalse(constructedError.badRequest)
        XCTAssertFalse(constructedError.clientError)
        XCTAssertFalse(constructedError.logicError)
        XCTAssertFalse(constructedError.unAuthenticated)
    }

    func test_logicError() throws {
        let basicErrorData = try JSONEncoder().encode(errorData)
        let constructedError = APIError.constructedError(data: basicErrorData, statusCode: 422)
        XCTAssertFalse(constructedError.badRequest)
        XCTAssertTrue(constructedError.clientError)
        XCTAssertTrue(constructedError.logicError)
        XCTAssertFalse(constructedError.unAuthenticated)
    }

    func test_unAuthenticatedError() throws {
        let basicErrorData = try JSONEncoder().encode(errorData)
        let constructedError = APIError.constructedError(data: basicErrorData, statusCode: 401)
        XCTAssertFalse(constructedError.badRequest)
        XCTAssertTrue(constructedError.clientError)
        XCTAssertFalse(constructedError.logicError)
        XCTAssertTrue(constructedError.unAuthenticated)
    }

    func test_constructedError_fromMockError() {
        let constructedError = APIError.constructedError(error: mockError)
        XCTAssertEqual(constructedError.message, "UNPARSEABLE_ERROR")
    }

    func test_constructedError_fromAPIError() {
        let constructedError = APIError.constructedError(error: mockError)
        let error = APIError.constructedError(error: constructedError)
        XCTAssertEqual(error.message, "UNPARSEABLE_ERROR")
    }

    func test_constructedError_fromAPIError_WithLocalizedDescription() {
        let error = APIError.constructedError(error: mockError)
        XCTAssertNil(error.title)
        XCTAssertEqual(error.message, "UNPARSEABLE_ERROR")
    }

    func test_constructedError_withTitle_andMessage() {
        let constructedError = APIError.constructedError(title: "Error", message: "Constructed Error Message Test")
        XCTAssertEqual(constructedError.title, "Error")
        XCTAssertEqual(constructedError.message, "Constructed Error Message Test")
    }

    func test_UnparsableError() {
        let unparseableError = APIError.unparseableError()
        XCTAssertEqual(unparseableError.title, "ERROR".localizedString)
        XCTAssertEqual(unparseableError.message, "UNPARSEABLE_ERROR".localizedString)
    }
}
