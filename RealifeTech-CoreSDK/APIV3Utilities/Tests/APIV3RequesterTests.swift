//
//  APIV3RequesterTests.swift
//  APIV3UtilitiesTests
//
//  Created by Olivier Butler on 07/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
import RxSwift
@testable import RealifeTech_CoreSDK

final class APIV3RequesterTests: XCTestCase  {

    let testRoot: String = "http://test.com"
    let testDeviceId: String = "ID123"
    private var testTokenManager: MockTokenManager = MockTokenManager()
    let expectedFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ"
    let expectedLocale: String = "en_US_POSIX"

    override func setUp() {
        APIV3RequesterHelper.deviceId = testDeviceId
        APIV3RequesterHelper.v3baseUrl = APIRoot(rawValue: testRoot)
        APIV3RequesterHelper.tokenManager = testTokenManager
    }

    override func tearDown() {
        testTokenManager = MockTokenManager()
    }

    func test_root() {
        XCTAssertEqual(MockRequester.root().rawValue, testRoot)
    }

    func test_dateFormatString() {
        XCTAssertEqual(MockRequester.dateFormatString(), expectedFormat)
    }

    func test_dateFormat() {
        guard let format = MockRequester.dateFormat() else {
            return XCTFail("No format returned")
        }
        switch format {
        case .formatted(let format, let localeIdentifier):
            XCTAssertEqual(localeIdentifier, expectedLocale)
            XCTAssertEqual(format, expectedFormat)
        default:
            XCTFail("Unexpected format returned")
        }
    }

    func test_format() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = expectedFormat
        formatter.locale = Locale(identifier: expectedLocale)
        let expectedResult = formatter.string(from: date)
        let result = MockRequester.format(date: date)
        XCTAssertEqual(result, expectedResult)
    }

    func test_interceptors() {
        guard let url = URL(string: "http://test.com") else {
            return XCTFail("Test setup failed")
        }
        var request = URLRequest(url: url)
        let testToken = "1234ZABC"
        testTokenManager.token = testToken
        testTokenManager.tokenIsValid = true

        guard let sutInterceptors = MockRequester.interceptors() else {
            return XCTFail("Did not get interceptors")
        }
        XCTAssertEqual(sutInterceptors.count, 3)
        sutInterceptors.forEach {
            request = $0(request)
        }
        guard let headerFields = request.allHTTPHeaderFields else {
            return XCTFail("No header fields added to request")
        }
        XCTAssertTrue(headerFields.contains(where: { tuple in
            let(key, value) = tuple
            return key == "Content-Type" && value == "application/json; charset=utf-8"
        }))
        XCTAssertTrue(headerFields.contains(where: { tuple in
            let(key, value) = tuple
            let expectedHeader = RequestHeader.generateDeviceIdHeader(deviceId: testDeviceId)
            return key == expectedHeader.header && value == expectedHeader.valueForHeader
        }))
        XCTAssertTrue(headerFields.contains(where: { tuple in
            let(key, value) = tuple
            let expectedHeader = RequestHeader.generateAuthHeader(accessToken: testToken)
            return key == expectedHeader.header && value == expectedHeader.valueForHeader
        }))
    }

    func test_preDispatchAction_none() {
        testTokenManager.getTokenObservable = nil
        XCTAssertNil(MockRequester.preDispatchAction())
    }

    func test_preDispatchAction_some() {
        let bag = DisposeBag()
        let source = PublishSubject<Void>()
        testTokenManager.getTokenObservable = source.asObservable()
        guard let resultObservable = MockRequester.preDispatchAction() else {
            return XCTFail("No pre-dispatch action returned")
        }
        let expectation = XCTestExpectation(description: "Pre-dispatch action did execute")
        resultObservable
            .subscribe({ _ in
                expectation.fulfill()
            })
            .disposed(by: bag)
        source.onNext(())
        wait(for: [expectation], timeout: 0.2)
    }
}

private struct MockRequester: APIV3Requester {}

private final class MockTokenManager: V3APITokenManagable {

    var token: String?
    var tokenIsValid: Bool = false
    var getTokenObservable: Observable<Void>?

    func getValidToken(_ completion: (() -> Void)?) {
        completion?()
    }
}
