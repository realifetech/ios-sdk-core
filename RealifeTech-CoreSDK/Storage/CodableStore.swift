//
//  CodableStorage.swift
//  RealifeTech
//
//  Created by Jonathon Albert on 19/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public protocol Storeable {
    func fetchAll<Model: Decodable>() throws -> [Model]
    func fetch<Model: Decodable>(for key: String) throws -> Model
    func save<Model: Encodable>(_ value: Model, for key: String) throws
    func delete(key: String)
}

public class CodableStore: Storeable {

    private let storage: DataStorage
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private let storagePrefix: String

    public init(
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

    public func fetchAll<Model: Decodable>() throws -> [Model] {
        let dataArray = try storage.fetchValues(with: storagePrefix)
        let mappedArray = try dataArray.map({ try decoder.decode(Model.self, from: $0) })
        return mappedArray
    }

    public func fetch<Model: Decodable>(for key: String) throws -> Model {
        let data = try storage.fetchValue(for: storagePrefix + key)
        return try decoder.decode(Model.self, from: data)
    }

    public func save<Model: Encodable>(_ value: Model, for key: String) throws {
        let data = try encoder.encode(value)
        try storage.save(value: data, for: storagePrefix + key)
    }

    public func delete(key: String) {
        storage.deleteValue(for: storagePrefix + key)
    }
}
