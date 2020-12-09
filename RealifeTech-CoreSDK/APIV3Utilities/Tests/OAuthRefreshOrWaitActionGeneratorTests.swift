//
//  OAuthRefreshOrWaitActionGeneratorTests.swift
//  APIV3UtilitiesTests
//
//  Created by Olivier Butler on 08/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import RealifeTech_CoreSDK

final class OAuthRefreshOrWaitActionGeneratorTests: XCTestCase {

    let emptyToken = OAuthToken(accessToken: nil,
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

    func test_refreshOrWaitAction_refreshInProgress() {
        let scheduler = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        let refreshCompleteStream = scheduler.createColdObservable([
            Recorded.next(100, true),
            Recorded.next(300, true),
            Recorded.completed(500)])
        let watcher = MockWatcher()
        watcher.ongoingTokenRefresh = refreshCompleteStream.asObservable()
        let store = MockStore()
        let worker = MockWorker(oAuthTokenObservable: Observable.just(emptyToken))
        let sut = OAuthRefreshOrWaitActionGenerator(
            authorisationWorker: worker,
            oAuthTokenRefreshWatcher: watcher,
            authorisationStore: store)
        guard let outputStream = sut.refreshTokenOrWaitAction else {
            return XCTFail("No refreshOrWait observable provided")
        }
        let observer = scheduler.createObserver(Bool.self)
        outputStream
            .asDriver(onErrorJustReturn: Void())
            .map({ _ in return true }) // We have to map to a Bool since Void is not equatable
            .drive(observer)
            .disposed(by: disposeBag)
        scheduler.start()

        let expectedEvents = [
            Recorded.next(100, true),
            Recorded.completed(100)
        ]
        XCTAssertEqual(expectedEvents, observer.events)
    }

    func test_refreshOrWaitAction_getToken_success() {
        let inputEvents = [
            Recorded.next(100, emptyToken),
            Recorded.next(300, emptyToken),
            Recorded.completed(500)]
        let refreshEvents = [
            Recorded.next(100, true),
            Recorded.completed(100)]
        let tokenStatuses = [
            OAuthTokenStatus.refreshing,
            OAuthTokenStatus.valid]
        refreshOrWaitAction_getToken(inputEvents: inputEvents,
                                     expectedRefreshEvents: refreshEvents,
                                     expectedTokenStatuses: tokenStatuses)
    }

    func test_refreshOrWaitAction_getToken_failure() {
        let inputEvents: [Recorded<Event<OAuthToken>>] = [
            Recorded.error(100, MockError())]
        let refreshEvents = [
            Recorded.next(100, true),
            Recorded.completed(100)]
        let tokenStatuses = [
            OAuthTokenStatus.refreshing,
            OAuthTokenStatus.invalid]
        refreshOrWaitAction_getToken(inputEvents: inputEvents,
                                     expectedRefreshEvents: refreshEvents,
                                     expectedTokenStatuses: tokenStatuses)
    }

    private func refreshOrWaitAction_getToken(
        inputEvents: [Recorded<Event<OAuthToken>>],
        expectedRefreshEvents: [Recorded<Event<Bool>>],
        expectedTokenStatuses: [OAuthTokenStatus]
    ) {
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
        guard let outputStream = sut.refreshTokenOrWaitAction else {
            return XCTFail("No refreshOrWait observable provided")
        }
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

    func saveCredentials(token: String, secondsExpiresIn: Int) {}
    func removeCredentials() {}
}

private final class MockWorker: AuthorisationWorkable {

    var requestInitialAccessToken: Observable<OAuthToken>

    init(oAuthTokenObservable: Observable<OAuthToken>) {
        self.requestInitialAccessToken = oAuthTokenObservable
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
