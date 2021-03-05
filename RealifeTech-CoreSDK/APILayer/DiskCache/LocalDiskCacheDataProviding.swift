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

    static var diskCache: DiskCachable {
        return DiskCache()
    }

    static var diskCacheCodableInterface: DiskCacheCodableInterface {
        return DiskCacheCodableInterface(diskCache: diskCache)
    }

    private static func fullFileName(identifier: String, privateObj: Bool = false) -> String {
        let postfix = privateObj ? DiskCache.privateIndicator : ""
        return baseFileName + "-" + identifier + postfix
    }

    static func saveItem<Model: Codable>(
        codable: Model,
        identifier: String,
        privateObj: Bool = false
    ) {
        try? diskCacheCodableInterface.save(
            codable,
            with: fullFileName(identifier: identifier, privateObj: privateObj),
            canFileBeExpired: false)
    }

    static func item(withIdentifier identifier: String, privateObj: Bool = false) -> Cdble? {
        return diskCacheCodableInterface.local(
            of: Cdble.self,
            fileName: fullFileName(identifier: identifier, privateObj: privateObj),
            includeExpired: true)
            .object
    }

    static var items: [Cdble] {
        return diskCacheCodableInterface.localItems(of: Cdble.self, wite: baseFileName)
    }

    private static var baseFileName: String {
        return "\(self)"
    }

    static func deleteItem(withIdentifier identifier: String) {
        diskCache.deleteItem(with: fullFileName(identifier: identifier))
    }
}
