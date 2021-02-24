//
//  DiskStorageTests.swift
//  RealifeTechTests
//
//  Created by Jonathon Albert on 22/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class DiskStorageTests: XCTestCase {

    private struct TestObject: Codable {
        let name: String
        let date: Date
    }

    private let testData = Data()
    private let writeSut: DiskStorage = makeSut()
    private let readSut: DiskStorage = makeSut()

    override func setUp() {
        writeSut.deleteValue(for: "diskStorageData")
    }

    override func tearDown() {
        writeSut.deleteValue(for: "diskStorageData")
    }

    func test_saveValue() {
        let currentDate = Date()
        let object = TestObject(name: "diskStorageData", date: currentDate)
        do {
            let encodedObject = try JSONEncoder.init().encode(object)
            try writeSut.save(value: encodedObject, for: "diskStorageData")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func test_saveValue_withHandler() {
        writeSut.save(value: testData, for: "diskStorageData", handler: { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
    }

    func test_deleteValue() {
        XCTAssertNoThrow(try writeSut.save(value: testData, for: "diskStorageData"))
        writeSut.deleteValue(for: "diskStorageData")
        XCTAssertThrowsError(try readSut.fetchValue(for: "diskStorageData"))
    }

    func test_fetchValues() {
        XCTAssertNoThrow(try writeSut.save(value: testData, for: "diskStorageData"))
        do {
            let dataArray = try readSut.fetchValues(with: "diskStorageData")
            XCTAssertEqual(dataArray.count, 1)
        } catch {
            XCTFail("Failed to fetch data")
        }
    }

    func test_fetchValues_isEmpty() {
        XCTAssertThrowsError(try readSut.fetchValues(with: "falseStorageData"))
    }

    func test_fetchValue() {
        let currentDate = Date()
        let object = TestObject(name: "diskStorageData", date: currentDate)
        do {
            let encodedObject = try JSONEncoder.init().encode(object)
            try writeSut.save(value: encodedObject, for: "diskStorageData")
            let objectData = try readSut.fetchValue(for: "diskStorageData")
            let decodedObject = try JSONDecoder.init().decode(TestObject.self, from: objectData)
            XCTAssertEqual(decodedObject.name, "diskStorageData")
            XCTAssertEqual(decodedObject.date, currentDate)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func test_fetchValue_withHandler() {
        XCTAssertNoThrow(try writeSut.save(value: testData, for: "diskStorageData"))
        readSut.fetchValue(for: "diskStorageData", handler: { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
    }

    private final class func makeSut() -> DiskStorage {
        let path = URL(fileURLWithPath: NSTemporaryDirectory())
        return DiskStorage(path: path)
    }
}
