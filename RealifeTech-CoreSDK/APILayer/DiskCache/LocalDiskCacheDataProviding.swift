//
//  LocalDiskCacheDataProviding.swift
//  CLArena
//
//  Created by Ross Patman on 18/06/2018.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

// Provides cache based CRUD operations for locally created objects
public protocol LocalDiskCacheDataProviding {
    associatedtype Cdble: Codable
}
public extension LocalDiskCacheDataProviding {
    static var baseFileName: String {
        return "\(self)"
    }
    static func fullFileName(identifier: String, privateObj: Bool = false) -> String {
        return baseFileName + "-" + identifier + (privateObj ? DiskCache.privateIndicator : "")
    }
    static func saveItem<T: Codable>(codable: T, identifier: String, privateObj: Bool = false) {
        DiskCacheCodableInterface.save(codable: codable, fileName: fullFileName(identifier: identifier, privateObj: privateObj), fileExpires: false)
    }
    static func item(withIdentifier identifier: String, privateObj: Bool = false) -> Cdble? {
        return DiskCacheCodableInterface.local(ofType: Cdble.self, fileName: fullFileName(identifier: identifier, privateObj: privateObj), includeExpired: true).obj
    }
    static var items: [Cdble] {
        return DiskCacheCodableInterface.localItems(ofType: Cdble.self, withBaseFileName: baseFileName)
    }
    static func deleteItem(withIdentifier identifier: String) {
        DiskCache.deleteItem(fileWithName: fullFileName(identifier: identifier))
    }
}
