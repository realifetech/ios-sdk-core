//
//  DiskStorage.swift
//  Analytics
//
//  Created by Jonathon Albert on 15/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

class DiskStorage {

    private let queue: DispatchQueue
    private let fileManager: FileManager
    private let path: URL

    init(
        path: URL,
        queue: DispatchQueue = .init(label: "DiskCache.Queue"),
        fileManager: FileManager = FileManager.default
    ) {
        self.path = path
        self.queue = queue
        self.fileManager = fileManager
    }

    private func createFolders(in url: URL) throws {
        let folderUrl = url.deletingLastPathComponent()
        if !fileManager.fileExists(atPath: folderUrl.path) {
            try fileManager.createDirectory(
                at: folderUrl,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
    }
}

extension DiskStorage: WritableStorage {

    func save(value: Data, for key: String) throws {
        let url = path.appendingPathComponent(key)
        do {
            try self.createFolders(in: url)
            try value.write(to: url, options: .atomic)
        } catch {
            throw StorageError.cantWrite(error)
        }
    }

    func save(value: Data, for key: String, handler: @escaping Handler<Data>) {
        queue.async {
            do {
                try self.save(value: value, for: key)
                handler(.success(value))
            } catch {
                handler(.failure(error))
            }
        }
    }

    func deleteValue(for key: String) {
        let url = path.appendingPathComponent(key)
        do {
            try? fileManager.removeItem(atPath: url.path)
        }
    }
}

extension DiskStorage: ReadableStorage {

    func fetchValues(with prefix: String) throws -> [Data] {
        let fileArray = try fileManager.contentsOfDirectory(
            at: path,
            includingPropertiesForKeys: nil,
            options: [.skipsHiddenFiles])
        let filteredData: [Data] = fileArray
            .filter({ ($0.lastPathComponent.contains(prefix)) })
            .compactMap({ fileManager.contents(atPath: $0.path) })
        if filteredData.isEmpty {
            throw StorageError.notFound
        } else {
            return filteredData
        }
    }

    func fetchValue(for key: String) throws -> Data {
        let url = path.appendingPathComponent(key)
        guard let data = fileManager.contents(atPath: url.path) else {
            throw StorageError.notFound
        }
        return data
    }

    func fetchValue(for key: String, handler: @escaping Handler<Data>) {
        queue.async {
            handler(Result { try self.fetchValue(for: key) })
        }
    }
}
