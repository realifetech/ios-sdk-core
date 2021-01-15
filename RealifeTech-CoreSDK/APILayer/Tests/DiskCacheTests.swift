//
//  DiskCacheTests.swift
//  CLArenaTests
//
//  Created by Ross Patman on 13/06/2018.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

struct TestObj: Codable {
    let id: String
    let otherField: Int
}

struct TestObjLocalRepository: LocalDiskCacheDataProviding {
    typealias Cdble = TestObj
}

struct DelTestObjLocalRepository: LocalDiskCacheDataProviding {
    typealias Cdble = TestObj
}

final class DiskCacheTests: XCTestCase {

    func testLocalFullFileName() {
        XCTAssert(TestObjLocalRepository.fullFileName(identifier: "123", privateObj: true) == "TestObjLocalRepository-123-private")
        XCTAssert(TestObjLocalRepository.fullFileName(identifier: "123") == "TestObjLocalRepository-123")
    }

    func deleteObjs() {
        TestObjLocalRepository.deleteItem(withIdentifier: "122")
        TestObjLocalRepository.deleteItem(withIdentifier: "123")
        TestObjLocalRepository.deleteItem(withIdentifier: "124")
    }

    func testSingleItemSaveRead() {
        deleteObjs()
        let obj = TestObj(id: "122", otherField: 455)
        TestObjLocalRepository.saveItem(codable: obj, identifier: "\(obj.id)")
        let fileName = TestObjLocalRepository.fullFileName(identifier: "\(obj.id)")
        let rawItem = DiskCache.read(fileName: fileName)
        XCTAssertNotNil(rawItem.file)
        let rawItems = DiskCache.readItems(withBaseFileName: TestObjLocalRepository.baseFileName)
        XCTAssert(rawItems.count == 1)
    }

    func testMultipleItemsSaveRead() {
        deleteObjs()
        let obj = TestObj(id: "123", otherField: 456)
        let obj2 = TestObj(id: "124", otherField: 457)
        TestObjLocalRepository.saveItem(codable: obj, identifier: "\(obj.id)")
        TestObjLocalRepository.saveItem(codable: obj2, identifier: "\(obj2.id)")
        let rawItems = DiskCache.readItems(withBaseFileName: TestObjLocalRepository.baseFileName)
        XCTAssert(rawItems.count == 2)
    }

    func testDeleteItem() {
        let obj = TestObj(id: "125", otherField: 459)
        let fileName = DelTestObjLocalRepository.fullFileName(identifier: "\(obj.id)")
        DelTestObjLocalRepository.saveItem(codable: obj, identifier: "\(obj.id)")
        let rawItem = DiskCache.read(fileName: fileName)
        XCTAssertNotNil(rawItem.file)
        DelTestObjLocalRepository.deleteItem(withIdentifier: "\(obj.id)")
        let rawItems = DiskCache.readItems(withBaseFileName: DelTestObjLocalRepository.baseFileName)
        XCTAssert(rawItems.count == 0)
    }
}
