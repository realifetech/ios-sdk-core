//
//  OAuthRefreshOrWaitActionGeneratorTests.swift
//  APIUtilitiesTests
//
//  Created by Olivier Butler on 08/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import RealifeTech_CoreSDK

final class OAuthRefreshOrWaitActionGeneratorTests: XCTestCase {

    let emptyToken = OAuthToken(
        accessToken: nil,
        refreshToken: nil,
        expiresIn: nil,
        tokenType: nil,
        scope: nil)

    func test_refreshOrWaitAction_noRefreshValidToken() {
        let store = MockStore()
        let watcher = MockWatcher()
        let worker = MockWorker(oAuthTokenObservable: Observable.just(emptyToken))
        let sut = OAuthRefreshOrWaitActionGenerator(
            authorisationWorker: worker,
            oAuthTokenRefreshWatcher: watcher,
            authorisationStore: store)
        store.accessTokenValid = true
        watcher.ongoingTokenRefresh = nil
        XCTAssertNil(sut.refreshTokenOrWaitAction)
    }

    func test_refreshOrWaitAction_refreshInProgress() throws {
        let scheduler = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        let refreshCompleteStream = scheduler.createColdObservable([
            Recorded.next(10, true),
            Recorded.next(30, true),
            Recorded.completed(30)])
        let watcher = MockWatcher()
        watcher.ongoingTokenRefresh = refreshCompleteStream.asObservable()
        let store = MockStore()
        let worker = MockWorker(oAuthTokenObservable: Observable.just(emptyToken))
        let sut = OAuthRefreshOrWaitActionGenerator(
            authorisationWorker: worker,
            oAuthTokenRefreshWatcher: watcher,
            authorisationStore: store)
        let outputStream = try XCTUnwrap(sut.refreshTokenOrWaitAction)
        let observer = scheduler.createObserver(Bool.self)
        outputStream
            .asDriver(onErrorJustReturn: Void())
            .map({ _ in return true }) // We have to map to a Bool since Void is not equatable
            .drive(observer)
            .disposed(by: disposeBag)
        scheduler.start()

        let expectedEvents = [
            Recorded.next(30, true),
            Recorded.completed(30)
        ]
        XCTAssertEqual(expectedEvents, observer.events)
    }

    func test_refreshOrWaitAction_getToken_success() throws {
        let inputEvents = [
            Recorded.next(10, emptyToken),
            Recorded.next(30, emptyToken),
            Recorded.completed(30)]
        let refreshEvents = [
            Recorded.next(30, true),
            Recorded.completed(30)]
        let tokenStatuses = [
            OAuthTokenStatus.refreshing,
            OAuthTokenStatus.valid]
        try refreshOrWaitAction_getToken(
            inputEvents: inputEvents,
            expectedRefreshEvents: refreshEvents,
            expectedTokenStatuses: tokenStatuses)
    }

    func test_refreshOrWaitAction_getToken_failure() throws {
        let inputEvents: [Recorded<Event<OAuthToken>>] = [
            Recorded.error(10, MockError())]
        let refreshEvents = [
            Recorded.next(10, true),
            Recorded.completed(10)]
        let tokenStatuses = [
            OAuthTokenStatus.refreshing,
            OAuthTokenStatus.invalid]
        try refreshOrWaitAction_getToken(
            inputEvents: inputEvents,
            expectedRefreshEvents: refreshEvents,
            expectedTokenStatuses: tokenStatuses)
    }

    private func refreshOrWaitAction_getToken(
        inputEvents: [Recorded<Event<OAuthToken>>],
        expectedRefreshEvents: [Recorded<Event<Bool>>],
        expectedTokenStatuses: [OAuthTokenStatus]
    ) throws {
        let scheduler = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        let tokenStream = scheduler.createColdObservable(inputEvents)
        let watcher = MockWatcher()
        let store = MockStore()
        let worker = MockWorker(oAuthTokenObservable: tokenStream.asObservable())
        let sut = OAuthRefreshOrWaitActionGenerator(
            authorisationWorker: worker,
            oAuthTokenRefreshWatcher: watcher,
            authorisationStore: store)
        let outputStream = try XCTUnwrap(sut.refreshTokenOrWaitAction)
        let observer = scheduler.createObserver(Bool.self)
        outputStream
            .asDriver(onErrorJustReturn: Void())
            .map({ _ in return true }) // We have to map to a Bool since Void is not equatable
            .drive(observer)
            .disposed(by: disposeBag)
        scheduler.start()
        XCTAssertEqual(expectedRefreshEvents, observer.events)
        XCTAssertEqual(expectedTokenStatuses, watcher.refreshStatusValues)
    }
}

private final class MockStore: AuthorisationStoring {

    var accessToken: String?
    var accessTokenValid: Bool = false
    var refreshToken: String?
    var refreshTokenValid: Bool = false

    func saveCredentials(token: String, secondsExpiresIn: Int, refreshToken: String?) {}
    func removeCredentials() {}
}

private final class MockWorker: AuthorisationWorkable {

    var requestInitialAccessToken: Observable<OAuthToken>
    var refreshAccessToken: Observable<OAuthToken>?

    init(oAuthTokenObservable: Observable<OAuthToken>) {
        self.requestInitialAccessToken = oAuthTokenObservable
        self.refreshAccessToken = nil
    }
}

private final class MockWatcher: OAuthTokenRefreshWatchable {

    var ongoingTokenRefresh: Observable<Bool>?
    var refreshStatusValues: [OAuthTokenStatus] = []

    func updateRefreshingStatus(newValue: OAuthTokenStatus) {
        refreshStatusValues.append(newValue)
    }
}

private struct MockError: Error {}
