//
//  Dictionary+ExtensionTests.swift
//  RealifeTechTests
//
//  Created by Olivier Butler on 16/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class DictionaryExtensionTests: XCTestCase {

    func test_dictionaryRemovingNilValuesFromDictionary() {
        let testDict = [
            "hello": 123,
            "my": nil,
            "name": 345,
            "is": nil,
            "terry": nil
        ]
        let result = dictionaryRemovingNilValuesFromDictionary(testDict as [String : AnyObject?])
        result.enumerated().forEach {
            XCTAssertNotNil($0.1)
        }
        XCTAssertEqual(result["hello"] as? Int, testDict["hello"])
        XCTAssertEqual(result["name"] as? Int, testDict["name"])
    }
}
