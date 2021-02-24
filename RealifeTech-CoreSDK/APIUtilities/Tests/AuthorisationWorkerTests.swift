//
//  AuthorisationWorkerTests.swift
//  APIUtilities
//
//  Created by Olivier Butler on 08/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
import RxSwift
@testable import RealifeTech_CoreSDK

final class AuthorisationWorkerTests: XCTestCase {

    private var storeSpy: MockAuthorisationStore!
    var sut: AuthorisationWorker!

    private let testTokenString = "KENOT"
    private let testExpirySeconds = 1234
    private let disposeBag = DisposeBag()

    override func setUp() {
        storeSpy = MockAuthorisationStore()
        sut = AuthorisationWorker(authorisationStore: storeSpy, oAuthRepositoryType: MockOAuthRepository.self)
    }

    func test_requestInitialAccessToken_tokenIsCorrect() {
        let testOAuthToken = OAuthToken(
            accessToken: testTokenString,
            refreshToken: nil,
            expiresIn: testExpirySeconds,
            tokenType: nil,
            scope: nil)
        let expectation = XCTestExpectation(description: "OAuth observable did emit value")
        emitInitialAccessToken(initialToken: testOAuthToken) { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_requestInitialAccessToken_tokenIsStored() {
        let testOAuthToken = OAuthToken(
            accessToken: testTokenString,
            refreshToken: nil,
            expiresIn: testExpirySeconds,
            tokenType: nil,
            scope: nil)
        let expectation = XCTestExpectation(description: "OAuth observable did emit value")
        emitInitialAccessToken(initialToken: testOAuthToken) { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(storeSpy.savedCredentials?.token, testTokenString)
        XCTAssertEqual(storeSpy.savedCredentials?.secondsExpiresIn, testExpirySeconds)
    }

    private func emitInitialAccessToken(initialToken: OAuthToken, completion: @escaping (OAuthToken) -> Void) {
        let observable = sut.requestInitialAccessToken
        observable
            .subscribe(onNext: { token in
                XCTAssertEqual(token, initialToken)
                completion(token)
            }).disposed(by: disposeBag)
        MockOAuthRepository.accessTokenSource.onNext(initialToken)
    }

    func test_refreshAccessToken_hasRefreshTokenAndAccessTokenIsExpired_tokenIsStored() {
        storeSpy.accessTokenValid = false
        storeSpy.accessToken = testTokenString
        storeSpy.refreshToken = testTokenString
        let testOAuthToken = OAuthToken(
            accessToken: testTokenString,
            refreshToken: testTokenString,
            expiresIn: testExpirySeconds,
            tokenType: nil,
            scope: nil)
        let expectation = XCTestExpectation(description: "OAuth observable did emit value")
        emitRefreshAccessToken(initialToken: testOAuthToken) { [self] _ in
            XCTAssertEqual(storeSpy.savedCredentials?.token, testTokenString)
            XCTAssertEqual(storeSpy.savedCredentials?.secondsExpiresIn, testExpirySeconds)
            XCTAssertEqual(storeSpy.savedCredentials?.refreshToken, testTokenString)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_refreshAccessToken_hasNoRefreshToken_returnNilObservable() {
        storeSpy.accessTokenValid = false
        storeSpy.accessToken = testTokenString
        storeSpy.refreshToken = nil
        XCTAssertNil(sut.refreshAccessToken)
    }

    private func emitRefreshAccessToken(initialToken: OAuthToken, completion: @escaping (OAuthToken) -> Void) {
        let observable = sut.refreshAccessToken
        observable?
            .subscribe(onNext: { token in
                XCTAssertEqual(token, initialToken)
                completion(token)
            }).disposed(by: disposeBag)
        MockOAuthRepository.refreshAccessTokenSource.onNext(initialToken)
    }
}

private struct MockOAuthRepository: OAuthProviding {

    static let accessTokenSource = PublishSubject<OAuthToken>()
    static let refreshAccessTokenSource = PublishSubject<OAuthToken>()

    static func requestInitialAccessToken() -> Observable<OAuthToken> {
        return accessTokenSource.asObservable()
    }

    static func refreshAccessToken(_ refreshToken: String) -> Observable<OAuthToken> {
        return refreshAccessTokenSource.asObservable()
    }
}

private final class MockAuthorisationStore: AuthorisationStoring {

    var accessToken: String?
    var accessTokenValid: Bool = false
    var refreshToken: String?
    var refreshTokenValid: Bool = false
    var savedCredentials: StubToken?

    func saveCredentials(token: String, secondsExpiresIn: Int, refreshToken: String?) {
        savedCredentials = StubToken(
            token: token,
            secondsExpiresIn: secondsExpiresIn,
            refreshToken: refreshToken)
    }

    func removeCredentials() {}
}
