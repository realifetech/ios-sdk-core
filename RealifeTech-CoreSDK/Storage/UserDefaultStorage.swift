//
//  UserDefaultStorage.swift
//  RealifeTech
//
//  Created by Olivier Butler on 21/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public struct UserDefaultsStorage {
    let userDefaults: UserDefaults
    let dispatchQueue: DispatchQueue

    public init(
        userDefaults: UserDefaults = UserDefaults.standard,
        dispatchQueue: DispatchQueue = .init(label: "UserDefaults.Queue")
    ) {
        self.userDefaults = userDefaults
        self.dispatchQueue = dispatchQueue
    }
}

extension UserDefaultsStorage: ReadableStorage {

    func fetchValues(with prefix: String) throws -> [Data] {
        return try UserDefaults.standard.dictionaryRepresentation().keys.filter { key in
            key.starts(with: prefix)
        }.compactMap { key in
            return try fetchValue(for: key)
        }
    }

    func fetchValue(for key: String) throws -> Data {
        guard let data = userDefaults.data(forKey: key) else {
            throw StorageError.notFound
        }
        return data
    }

    func fetchValue(for key: String, handler: @escaping Handler<Data>) {
        dispatchQueue.async {
            guard let data = self.userDefaults.data(forKey: key) else {
                return handler(.failure(StorageError.notFound))
            }
            return handler(.success(data))
        }
    }

}

extension UserDefaultsStorage: WritableStorage {

    func save(value: Data, for key: String) throws {
        userDefaults.setValue(value, forKey: key)
    }

    func save(value: Data, for key: String, handler: @escaping Handler<Data>) {
        dispatchQueue.async {
            self.userDefaults.setValue(value, forKey: key)
            handler(.success(value))
        }
    }

    func deleteValue(for key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
