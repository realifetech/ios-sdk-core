//
//  CodableStorage.swift
//  RealifeTech
//
//  Created by Jonathon Albert on 19/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

protocol Storeable {
    func fetchAll<T: Decodable>() throws -> [T]
    func fetch<T: Decodable>(for key: String) throws -> T
    func save<T: Encodable>(_ value: T, for key: String) throws
    func delete(key: String)
}

class CodableStore: Storeable {

    private let storage: DataStorage
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private let storagePrefix: String

    init(
        storage: DataStorage,
        decoder: JSONDecoder = .init(),
        encoder: JSONEncoder = .init(),
        storagePrefix: String
    ) {
        self.storage = storage
        self.decoder = decoder
        self.encoder = encoder
        self.storagePrefix = storagePrefix
    }

    func fetchAll<T: Decodable>() throws -> [T] {
        let dataArray = try storage.fetchValues(with: storagePrefix)
        let mappedArray = try dataArray.map({ try decoder.decode(T.self, from: $0) })
        return mappedArray
    }

    func fetch<T: Decodable>(for key: String) throws -> T {
        let data = try storage.fetchValue(for: storagePrefix + key)
        return try decoder.decode(T.self, from: data)
    }

    func save<T: Encodable>(_ value: T, for key: String) throws {
        let data = try encoder.encode(value)
        try storage.save(value: data, for: storagePrefix + key)
    }

    func delete(key: String) {
        storage.deleteValue(for: storagePrefix + key)
    }
}
