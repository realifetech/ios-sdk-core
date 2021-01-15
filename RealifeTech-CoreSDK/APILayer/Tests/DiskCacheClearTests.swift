//
//  DiskCacheClearTests.swift
//  CLArenaTests
//
//  Created by Ross Patman on 10/06/2019.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class DiskCacheClearTests: XCTestCase {

    override func setUp() {
        clearObjs()
        populateObjs()
    }

    private var objs: [URL] {
        guard let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return [] }
        guard let files = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) else { return [] }
        return files.filter({ $0.absoluteString.contains("\(DiskCache.fileExtension)") })
    }

    private var objNames: [Substring] { return objs.map { $0.absoluteString.split(separator: "$")[1] } }

    func obj(forURL URL: URL) -> String? {
        guard let text = try? String(contentsOf: URL.absoluteURL, encoding: .utf8) else { return nil }
        return text
    }

    private func clearObjs() {
        for file in objs {
            try? FileManager.default.removeItem(atPath: file.path)
        }
    }

    private func populateObjs() {
        DiskCache.save(file: "1", withFileName: "$test1", fileExpires: true)
        DiskCache.save(file: "2", withFileName: "$test2", fileExpires: true, expiresTimestamp: 0)
        DiskCache.save(file: "3", withFileName: "$test3-private", fileExpires: false)
    }

    func testClearAll() {
        XCTAssert(objs.count == 3)
        let expectation = XCTestExpectation(description: "completed")
        DiskCache.clear(deletionStrategy: .all) {
            XCTAssert(self.objs.count == 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }

    func testClearPrivate() {
        XCTAssert(objs.count == 3)
        let expectation = XCTestExpectation(description: "completed")
        DiskCache.clear(deletionStrategy: .privateOnly) {
            let retrievedNames = self.objNames
            XCTAssert(retrievedNames.count == 2)
            XCTAssert(retrievedNames.contains("test1.diskcache"))
            XCTAssert(retrievedNames.contains("test2.diskcache"))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }

    func testClearOutdated() {
        XCTAssert(objs.count == 3)
        let expectation = XCTestExpectation(description: "completed")
        DiskCache.clear(deletionStrategy: .outdatedOnly) {
            let retrievedNames = self.objNames
            XCTAssert(retrievedNames.count == 2)
            XCTAssert(retrievedNames.contains("test1.diskcache"))
            XCTAssert(retrievedNames.contains("test3-private.diskcache"))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }

    func testClearNonPrivate() {
        XCTAssert(objs.count == 3)
        let expectation = XCTestExpectation(description: "completed")
        DiskCache.clear(deletionStrategy: .allNonPrivate) {
            let retrievedNames = self.objNames
            XCTAssert(retrievedNames.count == 1)
            XCTAssert(retrievedNames.contains("test3-private.diskcache"))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
}
