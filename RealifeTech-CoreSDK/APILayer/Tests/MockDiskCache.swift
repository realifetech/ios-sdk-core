//
//  MockDiskCache.swift
//  RealifeTech-CoreSDKTests
//
//  Created by Mickey Lee on 05/03/2021.
//

import Foundation
@testable import RealifeTech_CoreSDK

struct TestObject: Codable {

    let id: String

    static var local: TestObject {
        return TestObject(id: "1")
    }

    static var localData: Data? {
        return try? JSONEncoder().encode(local)
    }

    static var localString: String? {
        return String(data: localData ?? Data(), encoding: .utf8)
    }

    static var remote: TestObject {
        return TestObject(id: "2")
    }

    static var remoteData: Data? {
        return try? JSONEncoder().encode(remote)
    }

    static var remoteString: String? {
        return String(data: remoteData ?? Data(), encoding: .utf8)
    }
}

final class MockDiskCache: DiskCachable {

    var shouldReturnedFile = false

    var savedFileName: String?
    var readFileName: String?
    var readBaseFileName: String?
    var deletedFileName: String?

    func save(_ file: String, with fileName: String, fileCanBeExpired: Bool, expiresAt: Int64) throws {
        savedFileName = fileName
    }

    func readItem(with fileName: String, includeExpired: Bool) -> (file: String?, expired: Bool) {
        readFileName = fileName
        return (
            file: shouldReturnedFile ? TestObject.localString : nil,
            expired: false)
    }

    func readItems(with baseFileName: String) -> [String] {
        readBaseFileName = baseFileName
        return shouldReturnedFile ? [TestObject.localString ?? ""] : []
    }

    func deleteItem(with fileName: String) {
        deletedFileName = fileName
    }

    func clearItems(deletionStrategy: DiskCacheDeletionStrategy, completion: (() -> Void)?) { }

    func reset() {
        shouldReturnedFile = false
        savedFileName = nil
        readFileName = nil
        readBaseFileName = nil
        deletedFileName = nil
    }
}
