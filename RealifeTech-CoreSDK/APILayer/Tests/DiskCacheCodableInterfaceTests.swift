//
//  DiskCacheCodableInterfaceTests.swift
//  RealifeTech-CoreSDKTests
//
//  Created by Mickey Lee on 05/03/2021.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class DiskCacheCodableInterfaceTests: XCTestCase {

    private var diskCache: MockDiskCache!
    private var sut: DiskCacheCodableInterface!

    private let fileName = "test_file"

    override func setUp() {
        super.setUp()
        diskCache = MockDiskCache()
        sut = DiskCacheCodableInterface(diskCache: diskCache)
    }

    override func tearDown() {
        sut = nil
        diskCache = nil
        super.tearDown()
    }

    func test_local_fileExists() {
        diskCache.shouldReturnedFile = true
        let reesult = sut.local(of: TestObject.self, fileName: fileName)
        XCTAssertEqual(diskCache.readFileName, fileName)
        XCTAssertEqual(reesult.object?.id, TestObject.local.id)
    }

    func test_local_fileDoesntExist() {
        let reesult = sut.local(of: TestObject.self, fileName: fileName)
        XCTAssertEqual(diskCache.readFileName, fileName)
        XCTAssertNil(reesult.object)
    }

    func test_localItems_filesExist() {
        diskCache.shouldReturnedFile = true
        let result = sut.localItems(of: TestObject.self, with: fileName)
        XCTAssertEqual(diskCache.readBaseFileName, fileName)
        XCTAssertEqual(result.first?.id, TestObject.local.id)
    }

    func test_localItems_filesDontExist() {
        let result = sut.localItems(of: TestObject.self, with: fileName)
        XCTAssertEqual(diskCache.readBaseFileName, fileName)
        XCTAssertTrue(result.isEmpty)
    }

    func test_save() throws {
        try sut.save(TestObject.local, with: fileName)
        XCTAssertEqual(diskCache.savedFileName, fileName)
    }
}
