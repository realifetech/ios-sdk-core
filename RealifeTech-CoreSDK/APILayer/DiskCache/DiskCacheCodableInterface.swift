//
//  DiskCacheCodableInterface.swift
//  CLArena
//
//  Created by Ross Patman on 18/06/2018.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation
import RxSwift

public struct DiskCacheCodableInterface {

    private let diskCache: DiskCachable

    public init(diskCache: DiskCachable = DiskCache()) {
        self.diskCache = diskCache
    }

    /// Gets cached file into Codable object
    /// - Parameters:
    ///   - type: Codable type
    ///   - fileName: Cached file name. It's saved as the identifier of the request
    ///   - includeExpired: search files including expired caches
    ///   - dateFormat: Requester's data format
    /// - Returns: Object and if the caches file is expired
    func local<Model: Codable>(
        of type: Model.Type,
        fileName: String,
        includeExpired: Bool = false,
        dateFormat: RequesterDateFormat? = nil
    ) -> (object: Model?, expired: Bool) {
        let cache = diskCache.readItem(with: fileName, includeExpired: includeExpired)
        guard
            let file = cache.file,
            let data = file.data(using: .utf8),
            let json = try? decode(data: data, to: Model.self, dateFormat: dateFormat)
        else {
            return (object: nil, expired: false)
        }
        return (object: json, expired: cache.expired)
    }

    /// Gets caches files into Codable objects
    /// - Parameters:
    ///   - type: Codable type
    ///   - baseFileName: The class/struct name for the target
    /// - Returns: A list of objects
    func localItems<Model: Codable>(
        of type: Model.Type,
        with baseFileName: String
    ) -> [Model] {
        return diskCache
            .readItems(with: baseFileName)
            .map {
                guard let data = $0.data(using: .utf8) else { return nil }
                return try? decode(data: data, to: Model.self, dateFormat: nil)
            }
            .compactMap { $0 }
    }

    /// Saves the Codable object to disk cache
    /// - Parameters:
    ///   - object: Codable object
    ///   - fileName: Generally save the file named with requester's identifier
    ///   - canFileBeExpired: The value of this file is expirable. The default is true
    func save<Model: Codable>(
        _ object: Model,
        with fileName: String,
        canFileBeExpired: Bool = true
    ) throws {
        let encoder = makeEncoder(for: nil)
        guard
            let jsonData = try? encoder.encode(object),
            let file = String(data: jsonData, encoding: .utf8)
        else {
            return
        }
        try diskCache.save(
            file,
            with: fileName,
            fileCanBeExpired: canFileBeExpired,
            expiresAt: DiskCache.defaultExpiresAt)
    }

    /// Converts data into Codable object
    func decode<Model: Codable>(
        data: Data,
        to type: Model.Type,
        dateFormat: RequesterDateFormat?
    ) throws -> Model {
        do {
            return try makeDecoder(for: dateFormat).decode(Model.self, from: data)
        } catch {
            print(error)
            throw DiskCacheDataProvidingError.unparseable
        }
    }

    private func makeDecoder(for dateFormat: RequesterDateFormat?) -> JSONDecoder {
        let decoder = JSONDecoder()
        if let dateFormat = dateFormat {
            switch dateFormat {
            case .timestampMilliseconds:
                decoder.dateDecodingStrategy = .millisecondsSince1970
            case .timestampSeconds:
                decoder.dateDecodingStrategy = .secondsSince1970
            case .formatted(let format, let localeIdentifier):
                decoder.dateDecodingStrategy = .formatted(
                    dateDecodingStrategy(
                        dateFormat: format,
                        localeIdentifier: localeIdentifier))
            }
        }
        return decoder
    }

    private func makeEncoder(for dateFormat: RequesterDateFormat?) -> JSONEncoder {
        let encoder = JSONEncoder()
        if let dateFormat = dateFormat {
            switch dateFormat {
            case .timestampMilliseconds:
                encoder.dateEncodingStrategy = .millisecondsSince1970
            case .timestampSeconds:
                encoder.dateEncodingStrategy = .secondsSince1970
            case .formatted(let format, let localeIdentifier):
                encoder.dateEncodingStrategy = .formatted(
                    dateDecodingStrategy(
                        dateFormat: format,
                        localeIdentifier: localeIdentifier))
            }
        }
        return encoder
    }

    private func dateDecodingStrategy(dateFormat: String, localeIdentifier: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale(identifier: localeIdentifier)
        return formatter
    }
}
