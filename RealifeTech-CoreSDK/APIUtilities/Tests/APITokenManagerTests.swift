//
//  APITokenManagerTests.swift
//  APIUtilitiesTests
//
//  Created by Olivier Butler on 08/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
import RxSwift
@testable import RealifeTech_CoreSDK

final class APITokenManagerTests: XCTestCase {

    private var testStore: MockStore!
    private var testRefreshGenerator: MockRefreshGenerator!
    var sut: APITokenManager!

    override func setUp() {
        testStore = MockStore()
        testRefreshGenerator = MockRefreshGenerator()
        sut = APITokenManager(
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

    func test_storeCredentials() throws {
        sut.storeCredentials(accessToken: "A", secondsExpiresIn: 10, refreshToken: "B")
        let credentialsReceived = try XCTUnwrap(testStore.credentialsToSave)
        XCTAssertEqual(credentialsReceived.token, "A")
        XCTAssertEqual(credentialsReceived.secondsExpiresIn, 10)
        XCTAssertEqual(credentialsReceived.refreshToken, "B")
    }

    func test_removeCredentials() {
        sut.removeCredentials()
        XCTAssertTrue(testStore.removeCredentialsCalled)
    }
}

struct StubToken {
    let token: String
    let secondsExpiresIn: Int
    let refreshToken: String?
}

private final class MockStore: AuthorisationStoring {

    var accessToken: String?
    var accessTokenValid: Bool = false
    var refreshToken: String?
    var refreshTokenValid: Bool = false
    var credentialsToSave: StubToken?
    var removeCredentialsCalled: Bool = false

    func saveCredentials(token: String, secondsExpiresIn: Int, refreshToken: String?) {
        credentialsToSave = StubToken(
            token: token,
            secondsExpiresIn: secondsExpiresIn,
            refreshToken: refreshToken)
    }

    func removeCredentials() {
        removeCredentialsCalled = true
    }
}

private final class MockRefreshGenerator: OAuthRefreshOrWaitActionGenerating {
    var refreshTokenOrWaitAction: Observable<Void>?
}
