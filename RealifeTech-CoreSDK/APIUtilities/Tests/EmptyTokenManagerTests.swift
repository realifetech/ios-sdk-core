//
//  EmptyTokenManagerTests.swift
//  APIUtilitiesTests
//
//  Created by Olivier Butler on 09/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class EmptyTokenManagerTests: XCTestCase {

    func test_getValidToken() {
        let sut = EmptyTokenManager()
        var didExecuteCompletion: Bool = false
        sut.getValidToken { _ in
            didExecuteCompletion = true
        }
        XCTAssertTrue(didExecuteCompletion)
    }
}
