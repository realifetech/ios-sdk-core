//
//  CodableStorageTests.swift
//  RealifeTechTests
//
//  Created by Jonathon Albert on 22/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class CodableStorageTests: XCTestCase {

    private struct TestObject: Codable {
        let name: String
        let date: Date
    }

    let readSut = makeSut()
    let writeSut = makeSut()

    override func setUp() {
        super.setUp()
        do {
            let objects: [TestObject] = try readSut.fetchAll()
            objects.forEach { object in
                readSut.delete(key: object.name)
            }
        } catch {}
    }

    func test_fetchAll() {
        do {
            try saveObjects(5)
            let testObjects: [TestObject] = try readSut.fetchAll()
            XCTAssertEqual(testObjects.count, 5)
        } catch let error {
            XCTFail("Failed with error: \(error.localizedDescription)")
        }
    }

    func test_singleFetch() {
        do {
            try saveObjects(5)
            let testObject: TestObject = try readSut.fetch(for: "testObj3")
            XCTAssertNotNil(testObject)
        } catch let error {
            XCTFail("Failed with error: \(error.localizedDescription)")
        }
    }

    func test_saveValue() {
        let test = TestObject(name: "testObj", date: Date())
        do {
            try writeSut.save(test, for: test.name)
            let savedObject: TestObject = try readSut.fetch(for: test.name)
            XCTAssertNotNil(savedObject)
        } catch {
            XCTFail("Failed to save object")
        }
    }

    private func saveObjects(_ numberToSave: Int) throws {
        try Array(1...numberToSave).forEach({ index in
            let testObject: TestObject = TestObject(name: "testObj\(index)", date: Date())
            try writeSut.save(testObject, for: testObject.name)
        })
    }

    private static func makeSut() -> CodableStorage {
        let path = URL(fileURLWithPath: NSTemporaryDirectory())
        let sut = CodableStorage(storage: DiskStorage(path: path),
                                 storagePrefix: "test")
        return sut
    }
}
