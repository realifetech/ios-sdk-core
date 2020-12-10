//
//  RequestTimeLogger.swift
//  CLArena
//
//  Created by Mickey Lee on 11/06/2019.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public class RequestTimeLogger {

    public static let shared = RequestTimeLogger()
    var requestEntries = [String: Date]()
    let requestEntriesQueue = DispatchQueue(label: "requestEntriesQueue")

    func addRequest(withIdentifier identifier: String, andDate date: Date = Date()) {
        requestEntriesQueue.async {
            self.requestEntries[identifier] = date
        }
    }

    func removeRequest(withIdentifier identifier: String) {
        requestEntriesQueue.async {
            self.requestEntries.removeValue(forKey: identifier)
        }
    }

    public func containsSlowRequestsAndRemove() -> Bool {
        var isSlow = false
        for entry in requestEntries {
            guard RequestTimeLogger.isSlowRequest(requestDate: entry.value) else { continue }
            removeRequest(withIdentifier: entry.key)
            isSlow = true
        }
        return isSlow
    }

    static func isSlowRequest(requestDate: Date, currentDate: Date = Date()) -> Bool {
        return currentDate.timeIntervalSince(requestDate) >= 3
    }
}
