//
//  V3APITokenManagerTests.swift
//  APIV3UtilitiesTests
//
//  Created by Olivier Butler on 08/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
import RxSwift
@testable import RealifeTech_CoreSDK

final class V3APITokenManagerTests: XCTestCase {

    private var testStore: MockStore!
    private var testRefreshGenerator: MockRefreshGenerator!
    var sut: V3APITokenManager!

    override func setUp() {
        testStore = MockStore()
        testRefreshGenerator = MockRefreshGenerator()
        sut = V3APITokenManager(
            authorisationStore: testStore,
            oAuthRefreshOrWaitActionGenerator: testRefreshGenerator,
            subscibeOnScheduler: MainScheduler.instance)
    }

    func test_token() {
        let tokenValue = "TOKEN_654"
        testStore.accessToken = tokenValue
        XCTAssertEqual(sut.token, tokenValue)
    }

    func test_tokenIsValid() {
        testStore.accessTokenValid = true
        XCTAssertTrue(sut.tokenIsValid)
        testStore.accessTokenValid = false
        XCTAssertFalse(sut.tokenIsValid)
    }

    func test_refreshToken() {
        let refreshTokenValue = "REFRESH_TOKEN"
        testStore.refreshToken = refreshTokenValue
        XCTAssertEqual(sut.refreshToken, refreshTokenValue)
    }

    func test_refreshTokenIsValid() {
        testStore.refreshTokenValid = true
        XCTAssertTrue(sut.refreshTokenIsValid)
        testStore.refreshTokenValid = false
        XCTAssertFalse(sut.refreshTokenIsValid)
    }

    func test_getValidToken_noDelay() {
        testRefreshGenerator.refreshTokenOrWaitAction = nil
        var synchronousCompletionCheck = false
        sut.getValidToken { synchronousCompletionCheck = true }
        XCTAssertTrue(synchronousCompletionCheck)
    }

    func test_getValidToken_delayedByObservable() {
        let expectation = XCTestExpectation(description: "Valid token completion called")
        let observableSource = PublishSubject<Void>.just(())
        testRefreshGenerator.refreshTokenOrWaitAction = observableSource.asObservable()
        sut.getValidToken {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func test_storeCredentials() {
        sut.storeCredentials(accessToken: "A", secondsExpiresIn: 10, refreshToken: "B")
        XCTAssertEqual(testStore.credentialsToSave?.0, "A")
        XCTAssertEqual(testStore.credentialsToSave?.1, 10)
        XCTAssertEqual(testStore.credentialsToSave?.2, "B")
    }

    func test_removeCredentials() {
        sut.removeCredentials()
        XCTAssertTrue(testStore.removeCredentialsCalled)
    }
}

private final class MockStore: AuthorisationStoring {

    var accessToken: String?
    var accessTokenValid: Bool = false
    var refreshToken: String?
    var refreshTokenValid: Bool = false
    var credentialsToSave: (String, Int, String?)?
    var removeCredentialsCalled: Bool = false

    func saveCredentials(token: String, secondsExpiresIn: Int, refreshToken: String?) {
        credentialsToSave = (token, secondsExpiresIn, refreshToken)
    }

    func removeCredentials() {
        removeCredentialsCalled = true
    }
}

private final class MockRefreshGenerator: OAuthRefreshOrWaitActionGenerating {
    var refreshTokenOrWaitAction: Observable<Void>?
}
