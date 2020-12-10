//
//  Storage.swift
//  RealifeTech
//
//  Created by Olivier Butler on 21/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

typealias Handler<T> = (Result<T, Error>) -> Void
typealias DataStorage = ReadableStorage & WritableStorage

protocol ReadableStorage {

    /// Fetches call values where the storage key starts with the prefix.
    /// Note that this is suceptable to data races with other threads.
    func fetchValues(with prefix: String) throws -> [Data]

    /// Fetches value synchronously.
    /// Note that this is suceptable to data races with other threads.
    func fetchValue(for key: String) throws -> Data

    /// A thread safe fetch method (order is guaranteed), which will pass a result to the completion handler
    func fetchValue(for key: String, handler: @escaping Handler<Data>)
}

protocol WritableStorage {

    /// Saves value synchronously.
    /// Note that this is suceptable to data races with other threads.
    func save(value: Data, for key: String) throws

    /// A thread safe save method (order is guaranteed), which will pass a result to the completion handler
    func save(value: Data, for key: String, handler: @escaping Handler<Data>)

    /// Removes value synchronously.
    /// Note that this is suceptable to data races with other threads.
    func deleteValue(for key: String)
}

enum StorageError: Error {
    case notFound
    case cantWrite(Error)
}
