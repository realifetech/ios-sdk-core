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
        super.setUp()
        clearObjs()
        populateObjs()
    }

    private var objs: [URL] {
        guard
            let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
            let files = try? FileManager.default.contentsOfDirectory(
                at: dir,
                includingPropertiesForKeys: nil,
                options: .skipsHiddenFiles)
        else {
            return []
        }
        return files.filter({ $0.absoluteString.contains("\(DiskCache.fileExtension)") })
    }

    private var objNames: [Substring] {
        return objs.map { $0.absoluteString.split(separator: "$")[1] }
    }

    private func obj(forURL URL: URL) -> String? {
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

    func test_clearAll() {
        XCTAssertEqual(objs.count, 3)
        let expectation = XCTestExpectation(description: "completed")
        DiskCache.clear(deletionStrategy: .all) {
            XCTAssertTrue(self.objs.isEmpty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }

    func test_clearPrivate() {
        XCTAssertEqual(objs.count, 3)
        let expectation = XCTestExpectation(description: "completed")
        DiskCache.clear(deletionStrategy: .privateOnly) { [self] in
            XCTAssertEqual(objs.count, 2)
            let retrievedNames = objNames
            XCTAssert(retrievedNames.contains("test1.diskcache"))
            XCTAssert(retrievedNames.contains("test2.diskcache"))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }

    func test_clearOutdated() {
        XCTAssert(objs.count == 3)
        let expectation = XCTestExpectation(description: "completed")
        DiskCache.clear(deletionStrategy: .outdatedOnly) { [self] in
            let retrievedNames = objNames
            XCTAssertEqual(objs.count, 2)
            XCTAssert(retrievedNames.contains("test1.diskcache"))
            XCTAssert(retrievedNames.contains("test3-private.diskcache"))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }

    func test_clearNonPrivate() {
        XCTAssertEqual(objs.count, 3)
        let expectation = XCTestExpectation(description: "completed")
        DiskCache.clear(deletionStrategy: .allNonPrivate) { [self] in
            let retrievedNames = objNames
            XCTAssertEqual(objs.count, 1)
            XCTAssert(retrievedNames.contains("test3-private.diskcache"))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
}
