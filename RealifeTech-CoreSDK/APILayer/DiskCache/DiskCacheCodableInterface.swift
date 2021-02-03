//
//  DiskCacheCodableInterface.swift
//  CLArena
//
//  Created by Ross Patman on 18/06/2018.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation
import RxSwift

// Converts cached files into Codable objects
public struct DiskCacheCodableInterface {
    fileprivate static func dateDecodingStrategy(dateFormat: String, localeIdentifier: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale(identifier: localeIdentifier)
        return formatter
    }
    static func decoder(forDateFormat dateFormat: RequesterDateFormat? = nil) -> JSONDecoder {
        let decoder = JSONDecoder()
        if let dateFormat = dateFormat {
            switch dateFormat {
            case .timestampMilliseconds: decoder.dateDecodingStrategy = .millisecondsSince1970
            case .timestampSeconds: decoder.dateDecodingStrategy = .secondsSince1970
            case .formatted(let format, let localeIdentifier): decoder.dateDecodingStrategy = .formatted(dateDecodingStrategy(dateFormat: format, localeIdentifier: localeIdentifier))
            }
        }
        return decoder
    }
    static func encoder(forDateFormat dateFormat: RequesterDateFormat? = nil) -> JSONEncoder {
        let encoder = JSONEncoder()
        if let dateFormat = dateFormat {
            switch dateFormat {
            case .timestampMilliseconds: encoder.dateEncodingStrategy = .millisecondsSince1970
            case .timestampSeconds: encoder.dateEncodingStrategy = .secondsSince1970
            case .formatted(let format, let localeIdentifier): encoder.dateEncodingStrategy = .formatted(dateDecodingStrategy(dateFormat: format, localeIdentifier: localeIdentifier))
            }
        }
        return encoder
    }
    static func local<Model: Codable>(ofType type: Model.Type, fileName: String, includeExpired: Bool = false, dateFormat: RequesterDateFormat? = nil) -> (obj: Model?, expired: Bool) {
        let cacheResponse = DiskCache.read(fileName: fileName, includeExpired: includeExpired)
        if let file = cacheResponse.file, let data = file.data(using: .utf8), let json = try? decode(data: data, toType: Model.self, dateFormat: dateFormat) {
            return (obj: json, expired: cacheResponse.expired)
        }
        return (obj: nil, expired: false)
    }
    static func localItems<Model: Codable>(ofType type: Model.Type, withBaseFileName baseFileName: String) -> [Model] {
        return DiskCache.readItems(withBaseFileName: baseFileName).map {
            guard let data = $0.data(using: .utf8) else { return nil }
            return try? decode(data: data, toType: Model.self)
        }.compactMap { $0 }
    }
    static func decode<Model: Codable>(data: Data, toType: Model.Type, dateFormat: RequesterDateFormat? = nil) throws -> Model {
        do {
            return try decoder(forDateFormat: dateFormat).decode(Model.self, from: data)
        } catch {
            print(error)
            throw DiskCacheDataProvidingError.unparseable
        }
    }
    static func save<Model: Codable>(codable: Model, fileName: String, fileExpires: Bool = true) {
        guard let jsonData = try? JSONEncoder().encode(codable), let string = String(data: jsonData, encoding: .utf8) else { return }
        DiskCache.save(file: string, withFileName: fileName, fileExpires: fileExpires)
    }
}

// Util
public enum DiskCacheDataProvidingStrategy {
    case localOrRemoteIfExpired
    case localAndRemoteIfExpired
    case localAndRemote
    case localAndForcedRemote
    case remote
    case remoteWithoutCachingResponse
}
public enum DiskCacheDataProvidingError: Error, LocalizedError {
    case unparseable
    public var errorDescription: String? {
        switch self {
        case .unparseable: return "UNPARSEABLE_ERROR".localizedString
        }
    }
}
