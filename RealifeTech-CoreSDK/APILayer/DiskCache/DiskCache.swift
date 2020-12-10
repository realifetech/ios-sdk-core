//
//  DiskCache.swift
//  RX
//
//  Created by Ross Patman on 21/10/2017.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public extension Date {
    func toMilliseconds() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

public struct DiskCache {
    static let fileExtension: String = ".diskcache"
    static let privateIndicator: String = "-private"
    static let second: Int64 = 6000
    static let minute: Int64 = second * 60
    static let hour: Int64 = minute * 60
    static let day: Int64 = hour * 24
    static let cacheDuration: Int64 = minute * 10
    static let fileDuration: Int64 = day * 2

    public enum FileKey {
        case expiry, file
    }

    public enum DeletionStrategy {
        case all, privateOnly, outdatedOnly, allNonPrivate
    }

    static func save(file: String, withFileName fileName: String, fileExpires: Bool = true, expiresTimestamp: Int64 = Date().toMilliseconds()+cacheDuration) {
        guard let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        let fileURL = dir.appendingPathComponent("\(fileName)\(fileExtension)")
        let expiryTimestamp = fileExpires ? "\(expiresTimestamp)" : "NA"
        let text = "\(expiryTimestamp)|\(file)"
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch {
            print(error)
        }
    }

    static func read(fileName: String, includeExpired: Bool = false) -> (file: String?, expired: Bool) {
        guard let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return (file: nil, expired: false) }
        let fileURL = dir.appendingPathComponent("\(fileName)\(fileExtension)")
        do {
            let text = try String(contentsOf: fileURL, encoding: .utf8)
            let expired = fileExpired(text: text)
            if !includeExpired && expired {
                return (file: nil, expired: true)
            }
            return (file: fileComponent(text: text, key: .file), expired: expired)
        } catch {
            return (file: nil, expired: false)
        }
    }

    static func readItems(withBaseFileName baseFileName: String) -> [String] {
        guard let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return [] }
        guard let files = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) else { return [] }
        return files
            .filter { return $0.lastPathComponent.starts(with: baseFileName) }
            .map { try? String(contentsOf: $0.absoluteURL, encoding: .utf8) }
            .compactMap { $0 }
            .map { return fileComponent(text: $0, key: .file) }
            .compactMap { $0 }
    }

    public static func clear(deletionStrategy: DeletionStrategy, completion: (() -> Void)? = nil) {
        guard let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        DispatchQueue.global(qos: .background).async {
            guard let files = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) else { return }
            let fullExtension = deletionStrategy == .privateOnly ? "\(DiskCache.privateIndicator)\(DiskCache.fileExtension)" : "\(DiskCache.fileExtension)"
            for file in files.filter({ $0.absoluteString.contains(fullExtension) }) {
                var shouldDelete = false
                switch deletionStrategy {
                case .all, .privateOnly: shouldDelete = true
                case .allNonPrivate: shouldDelete = !file.absoluteString.contains("\(DiskCache.privateIndicator)")
                case .outdatedOnly:
                    guard let text = try? String(contentsOf: file.absoluteURL, encoding: .utf8) else { continue }
                    shouldDelete = fileExpired(text: text, andAlsoOutdated: true)
                }
                guard shouldDelete else { continue }
                try? FileManager.default.removeItem(atPath: file.path)
            }
            completion?()
        }
    }

    static func deleteItem(fileWithName fileName: String) {
        guard let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        let fileURL = dir.appendingPathComponent("\(fileName)\(fileExtension)")
        try? FileManager.default.removeItem(at: fileURL)
    }

    private static func fileExpired(text: String, andAlsoOutdated alsoOutdated: Bool = false) -> Bool {
        guard let expiry = fileComponent(text: text, key: .expiry) else { return true }
        guard let expiryDate = Int64(expiry) else { return false }
        let currentDate = Int64(Date().toMilliseconds())
        if alsoOutdated {
            return currentDate - expiryDate > fileDuration
        } else {
            return currentDate > expiryDate
        }
    }
    
    private static func fileComponent(text: String, key: FileKey) -> String? {
        let components = text.split(separator: "|", maxSplits: 1, omittingEmptySubsequences: true)
        guard components.count == 2 else { return nil }
        switch key {
        case .expiry: return String(components[0])
        case .file: return String(components[1])
        }
    }
}
