//
//  AuthorisationWorkerTests.swift
//  APIV3Utilities
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

    let testTokenString = "KENOT"
    let testExpirySeconds = 1234
    let disposeBag = DisposeBag()

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
        emitInitialAccessToken(initialToken: testOAuthToken) { token in
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
        emitInitialAccessToken(initialToken: testOAuthToken) { token in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        guard let(resultToken, resultExpiry) = storeSpy.savedCredentials else {
            return XCTFail("No token details saved to store")
        }
        XCTAssertEqual(resultToken, testTokenString)
        XCTAssertEqual(resultExpiry, testExpirySeconds)
    }

    private func emitInitialAccessToken(initialToken: OAuthToken, completion: @escaping (OAuthToken) -> ()) {
        let observable = sut.requestInitialAccessToken
        observable
            .subscribe(onNext: { token in
                XCTAssertEqual(token, initialToken)
                completion(token)
            }).disposed(by: disposeBag)
        MockOAuthRepository.accessTokenSource.onNext(initialToken)
    }
}

private struct MockOAuthRepository: OAuthProviding {
    static let accessTokenSource = PublishSubject<OAuthToken>()

    static func requestInitialAccessToken() -> Observable<OAuthToken> {
        return accessTokenSource.asObservable()
    }
}

private final class MockAuthorisationStore: AuthorisationStoring {

    var accessToken: String?
    var accessTokenValid: Bool = false
    var savedCredentials: (String, Int)?

    func saveCredentials(token: String, secondsExpiresIn: Int) {
        self.savedCredentials = (token, secondsExpiresIn)
    }

    func removeCredentials() {}
}
