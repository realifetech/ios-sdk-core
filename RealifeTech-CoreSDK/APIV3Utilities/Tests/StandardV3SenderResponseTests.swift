//
//  StandardV3SenderResponseTests.swift
//  StandardV3SenderResponseTests
//
//  Created by Olivier Butler on 07/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class StandardV3SenderResponseTests: XCTestCase {

    func test_isSuccess() {
        let sutSuccess = StandardV3SenderResponse(code: 200, type: nil, message: nil)
        let sutFailure = StandardV3SenderResponse(code: 400, type: nil, message: nil)
        XCTAssertTrue(sutSuccess.isSuccess)
        XCTAssertFalse(sutFailure.isSuccess)
    }
}
