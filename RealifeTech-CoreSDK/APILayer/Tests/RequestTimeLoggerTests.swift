//
//  RequestTimeLoggerTests.swift
//  CLArenaTests
//
//  Created by Ross Patman on 11/06/2019.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
@testable import RealifeTech_CoreSDK

final class RequestTimeLoggerTests: XCTestCase {

    func test_addRequests() {
        let timeLogger = RequestTimeLogger()
        timeLogger.addRequest(withIdentifier: "aaa", andDate: Date(timeIntervalSince1970: 0))
        timeLogger.requestEntriesQueue.async {
            XCTAssertEqual(timeLogger.requestEntries.count, 1)
        }
        timeLogger.addRequest(withIdentifier: "bbb", andDate: Date(timeIntervalSince1970: 0))
        timeLogger.requestEntriesQueue.async {
            XCTAssertEqual(timeLogger.requestEntries.count, 2)
        }
        timeLogger.addRequest(withIdentifier: "aaa", andDate: Date(timeIntervalSince1970: 1))
        timeLogger.requestEntriesQueue.async {
            XCTAssertEqual(timeLogger.requestEntries.count, 2)
        }
    }

    func test_removeRequests() {
        let timeLogger = RequestTimeLogger()
        timeLogger.addRequest(withIdentifier: "aaa", andDate: Date(timeIntervalSince1970: 0))
        timeLogger.addRequest(withIdentifier: "bbb", andDate: Date(timeIntervalSince1970: 1))
        timeLogger.removeRequest(withIdentifier: "ccc")
        timeLogger.requestEntriesQueue.async {
            XCTAssertEqual(timeLogger.requestEntries.count, 2)
        }
        timeLogger.removeRequest(withIdentifier: "aaa")
        timeLogger.requestEntriesQueue.async {
            XCTAssertEqual(timeLogger.requestEntries.count, 1)
            XCTAssertEqual(timeLogger.requestEntries.first?.key, "bbb")
        }
        timeLogger.removeRequest(withIdentifier: "bbb")
        timeLogger.requestEntriesQueue.async {
            XCTAssertTrue(timeLogger.requestEntries.isEmpty)
        }
        timeLogger.removeRequest(withIdentifier: "aaa")
        timeLogger.requestEntriesQueue.async {
            XCTAssertTrue(timeLogger.requestEntries.isEmpty)
        }
    }

    func test_noRequests() {
        let timeLogger = RequestTimeLogger()
        timeLogger.requestEntriesQueue.async {
            let containedSlow = timeLogger.containsSlowRequestsAndRemove()
            sleep(1)
            XCTAssertFalse(containedSlow)
            XCTAssertTrue(timeLogger.requestEntries.isEmpty)
        }
    }

    func test_slowRequests() {
        let timeLogger = RequestTimeLogger()
        timeLogger.addRequest(withIdentifier: "aaa", andDate: Date(timeIntervalSince1970: 0))
        timeLogger.requestEntriesQueue.async {
            let containedSlow = timeLogger.containsSlowRequestsAndRemove()
            sleep(1)
            XCTAssertTrue(containedSlow)
            XCTAssertTrue(timeLogger.requestEntries.isEmpty)
        }
    }

    func test_slowAndFastRequests() {
        let timeLogger = RequestTimeLogger()
        timeLogger.addRequest(withIdentifier: "aaa", andDate: Date(timeIntervalSince1970: 0))
        timeLogger.addRequest(withIdentifier: "bbb", andDate: Date(timeIntervalSinceNow: 20))
        timeLogger.requestEntriesQueue.async {
            let containedSlow = timeLogger.containsSlowRequestsAndRemove()
            sleep(1)
            XCTAssertTrue(containedSlow)
            XCTAssertEqual(timeLogger.requestEntries.count, 1)
            XCTAssertEqual(timeLogger.requestEntries.first?.key, "bbb")
        }
    }

    func test_fastRequests() {
        let timeLogger = RequestTimeLogger()
        timeLogger.addRequest(withIdentifier: "aaa", andDate: Date(timeIntervalSinceNow: 20))
        timeLogger.addRequest(withIdentifier: "bbb", andDate: Date(timeIntervalSinceNow: 21))
        timeLogger.requestEntriesQueue.async {
            let containedSlow = timeLogger.containsSlowRequestsAndRemove()
            sleep(1)
            XCTAssertFalse(containedSlow)
            XCTAssertEqual(timeLogger.requestEntries.count, 2)
        }
    }

    func testIsSlowRequest() {
        XCTAssertTrue(RequestTimeLogger.isSlowRequest(requestDate: Date(timeIntervalSince1970: 0), currentDate: Date(timeIntervalSince1970: 3)))
        XCTAssertTrue(RequestTimeLogger.isSlowRequest(requestDate: Date(timeIntervalSince1970: 0), currentDate: Date(timeIntervalSince1970: 4)))
    }

    func testIsFastRequest() {
        XCTAssertFalse(RequestTimeLogger.isSlowRequest(requestDate: Date(timeIntervalSince1970: 0), currentDate: Date(timeIntervalSince1970: 0)))
        XCTAssertFalse(RequestTimeLogger.isSlowRequest(requestDate: Date(timeIntervalSince1970: 0), currentDate: Date(timeIntervalSince1970: 2)))
    }
}
