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

    func testAddRequests() {
        let timeLogger = RequestTimeLogger()
        timeLogger.addRequest(withIdentifier: "aaa", andDate: Date(timeIntervalSince1970: 0))
        timeLogger.requestEntriesQueue.async {
            XCTAssert(timeLogger.requestEntries.count == 1)
        }
        timeLogger.addRequest(withIdentifier: "bbb", andDate: Date(timeIntervalSince1970: 0))
        timeLogger.requestEntriesQueue.async {
            XCTAssert(timeLogger.requestEntries.count == 2)
        }
        timeLogger.addRequest(withIdentifier: "aaa", andDate: Date(timeIntervalSince1970: 1))
        timeLogger.requestEntriesQueue.async {
            XCTAssert(timeLogger.requestEntries.count == 2)
        }
    }

    func testRemoveRequests() {
        let timeLogger = RequestTimeLogger()
        timeLogger.addRequest(withIdentifier: "aaa", andDate: Date(timeIntervalSince1970: 0))
        timeLogger.addRequest(withIdentifier: "bbb", andDate: Date(timeIntervalSince1970: 1))
        timeLogger.removeRequest(withIdentifier: "ccc")
        timeLogger.requestEntriesQueue.async {
            XCTAssert(timeLogger.requestEntries.count == 2)
        }
        timeLogger.removeRequest(withIdentifier: "aaa")
        timeLogger.requestEntriesQueue.async {
            XCTAssert(timeLogger.requestEntries.count == 1)
            XCTAssert(timeLogger.requestEntries.first?.key == "bbb")
        }
        timeLogger.removeRequest(withIdentifier: "bbb")
        timeLogger.requestEntriesQueue.async {
            XCTAssert(timeLogger.requestEntries.count == 0)
        }
        timeLogger.removeRequest(withIdentifier: "aaa")
        timeLogger.requestEntriesQueue.async {
            XCTAssert(timeLogger.requestEntries.count == 0)
        }
    }

    func testNoRequests() {
        let timeLogger = RequestTimeLogger()
        timeLogger.requestEntriesQueue.async {
            let containedSlow = timeLogger.containsSlowRequestsAndRemove()
            sleep(1)
            XCTAssertFalse(containedSlow)
            XCTAssert(timeLogger.requestEntries.count == 0)
        }
    }

    func testSlowRequests() {
        let timeLogger = RequestTimeLogger()
        timeLogger.addRequest(withIdentifier: "aaa", andDate: Date(timeIntervalSince1970: 0))
        timeLogger.requestEntriesQueue.async {
            let containedSlow = timeLogger.containsSlowRequestsAndRemove()
            sleep(1)
            XCTAssertTrue(containedSlow)
            XCTAssert(timeLogger.requestEntries.count == 0)
        }
    }

    func testSlowAndFastRequests() {
        let timeLogger = RequestTimeLogger()
        timeLogger.addRequest(withIdentifier: "aaa", andDate: Date(timeIntervalSince1970: 0))
        timeLogger.addRequest(withIdentifier: "bbb", andDate: Date(timeIntervalSinceNow: 20))
        timeLogger.requestEntriesQueue.async {
            let containedSlow = timeLogger.containsSlowRequestsAndRemove()
            sleep(1)
            XCTAssertTrue(containedSlow)
            XCTAssert(timeLogger.requestEntries.count == 1)
            XCTAssert(timeLogger.requestEntries.first?.key == "bbb")
        }
    }

    func testFastRequests() {
        let timeLogger = RequestTimeLogger()
        timeLogger.addRequest(withIdentifier: "aaa", andDate: Date(timeIntervalSinceNow: 20))
        timeLogger.addRequest(withIdentifier: "bbb", andDate: Date(timeIntervalSinceNow: 21))
        timeLogger.requestEntriesQueue.async {
            let containedSlow = timeLogger.containsSlowRequestsAndRemove()
            sleep(1)
            XCTAssertFalse(containedSlow)
            XCTAssert(timeLogger.requestEntries.count == 2)
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
