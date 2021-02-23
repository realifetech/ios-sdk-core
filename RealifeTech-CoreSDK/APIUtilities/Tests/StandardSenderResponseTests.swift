//
//  StandardSenderResponseTests.swift
//  StandardSenderResponseTests
//
//  Created by Olivier Butler on 07/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class StandardSenderResponseTests: XCTestCase {

    func test_isSuccess() {
        let sutSuccess = StandardSenderResponse(code: 200, type: nil, message: nil)
        let sutFailure = StandardSenderResponse(code: 400, type: nil, message: nil)
        XCTAssertTrue(sutSuccess.isSuccess)
        XCTAssertFalse(sutFailure.isSuccess)
    }
}
