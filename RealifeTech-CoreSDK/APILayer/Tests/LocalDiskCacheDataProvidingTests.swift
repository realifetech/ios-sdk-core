//
//  LocalDiskCacheDataProvidingTests.swift
//  RealifeTech-CoreSDKTests
//
//  Created by Mickey Lee on 05/03/2021.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class LocalDiskCacheDataProvidingTests: XCTestCase {

    private let object = TestObject.local
    private let fileName = "test_file"
    private lazy var expectedFileName = String(describing: LocalDiskCacheDataProvider.self) + "-" + fileName

    func test_saveItem_nonPrivateObject_savedFileWithoutPrivateIndicator() throws {
        LocalDiskCacheDataProvider.saveItem(codable: object, identifier: fileName)
        XCTAssertEqual(mockDiskCache.savedFileName, expectedFileName)
    }

    func test_saveItem_privateObject_savedFileWithPrivateIndicator() throws {
        LocalDiskCacheDataProvider.saveItem(
            codable: object,
            identifier: fileName,
            privateObj: true)
        XCTAssertEqual(mockDiskCache.savedFileName, expectedFileName + DiskCache.privateIndicator)
    }

    func test_itemWithIdentifier_callDiskCacheToReadFile() {
        _ = LocalDiskCacheDataProvider.item(withIdentifier: fileName)
        XCTAssertEqual(mockDiskCache.readFileName, expectedFileName)
    }

    func test_items_callDiskCacheToReadFiles() {
        _ = LocalDiskCacheDataProvider.items
        XCTAssertEqual(mockDiskCache.readBaseFileName, String(describing: LocalDiskCacheDataProvider.self))
    }

    func test_deleteItem_callDiskCacheToDeleteItem() {
        LocalDiskCacheDataProvider.deleteItem(withIdentifier: fileName)
        XCTAssertEqual(mockDiskCache.deletedFileName, expectedFileName)
    }
}

// MARK: - Mocks

private let mockDiskCache = MockDiskCache()

private final class LocalDiskCacheDataProvider: LocalDiskCacheDataProviding {

    typealias Cdble =  TestObject

    class var diskCache: DiskCachable {
        return mockDiskCache
    }
}
