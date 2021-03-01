//
//  AnalyticEvent.swift
//  Analytics
//
//  Created by Jonathon Albert on 15/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public struct AnalyticEvent: Codable {

    public var storedName: String?
    public let type: String
    public let action: String
    public let new: [String: String]?
    public let old: [String: String]?
    public let version: String
    public let timestamp: Date

    public var newString: String? { escape(new) }
    public var oldString: String? { escape(old) }
    public var timestampString: String { timestamp.rltFormatted }

    public init(
        type: String,
        action: String,
        new: [String: String]? = nil,
        old: [String: String]? = nil,
        version: String,
        timestamp: Date = Date()
    ) {
        self.type = type
        self.action = action
        self.new = new
        self.old = old
        self.version = version
        self.timestamp = timestamp
    }

    private func escape(_ dictionary: [String: String]?) -> String? {
        let encoder = JSONEncoder()
        guard
            dictionary != nil,
            let dictionaryString = try? encoder.encode(dictionary),
            let jsonString = String(data: dictionaryString, encoding: .utf8)
        else {
            return nil
        }
        return NSRegularExpression.escapedPattern(for: jsonString).replacingOccurrences(of: "\\", with: "")
    }
}

extension AnalyticEvent: Equatable {}
