//
//  ReadOnlyCurrentValueTests.swift
//  RealifeTechTests
//
//  Created by Olivier Butler on 26/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
import Combine
@testable import RealifeTech_CoreSDK

final class ReadOnlyCurrentValueTests: XCTestCase {

    func test_readsCorrectValue() {
        let initialStringValye = "initial"
        let laterStringValue = "second/later string"
        let underlyingValue = CurrentValueSubject<String, Never>.init(initialStringValye)
        let sut = ReadOnlyCurrentValue(from: underlyingValue)
        XCTAssertEqual(initialStringValye, sut.value)
        underlyingValue.send(laterStringValue)
        XCTAssertEqual(laterStringValue, sut.value)
    }
}
