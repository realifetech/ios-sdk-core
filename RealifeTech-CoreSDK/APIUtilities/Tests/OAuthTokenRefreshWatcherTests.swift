//
//  OAuthTokenRefreshWatcherTests.swift
//  APIUtilitiesTests
//
//  Created by Olivier Butler on 09/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import RealifeTech_CoreSDK

final class OAuthTokenRefreshWatcherTests: XCTestCase {

    func test_ongoingTokenRefresh_nilOnInit() {
        let sut = OAuthTokenRefreshWatcher()
        XCTAssertNil(sut.ongoingTokenRefresh)
    }

    func test_ongoingTokenRefresh_nonRefreshStatus_nil() {
        let sut = OAuthTokenRefreshWatcher()
        sut.updateRefreshingStatus(newValue: .invalid)
        XCTAssertNil(sut.ongoingTokenRefresh)
        sut.updateRefreshingStatus(newValue: .valid)
        XCTAssertNil(sut.ongoingTokenRefresh)
        sut.updateRefreshingStatus(newValue: .unknown)
        XCTAssertNil(sut.ongoingTokenRefresh)
    }

    func test_ongoingTokenRefresh_refreshing_hasValue() {
        let sut = OAuthTokenRefreshWatcher()
        sut.updateRefreshingStatus(newValue: .refreshing)
        XCTAssertNotNil(sut.ongoingTokenRefresh)
    }

    func test_ongoingTokenRefresh_refreshing_emitValueWhenValid() {
        let scheduler = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        let observer = scheduler.createObserver(Bool.self)
        let tokenStatusInput = scheduler.createColdObservable([
            Recorded.next(100, OAuthTokenStatus.invalid),
            Recorded.next(300, OAuthTokenStatus.refreshing),
            Recorded.next(400, OAuthTokenStatus.valid),
            Recorded.next(450, OAuthTokenStatus.unknown),
            Recorded.completed(500)])
        let expectedResult = [Recorded.next(400, true)]
        let tokenStatusSource = BehaviorRelay(value: OAuthTokenStatus.unknown)
        tokenStatusInput
            .bind(to: tokenStatusSource)
            .disposed(by: disposeBag)
        let sut = OAuthTokenRefreshWatcher(tokenStatusSource: tokenStatusSource)
        sut.updateRefreshingStatus(newValue: .refreshing)

        guard let observable = sut.ongoingTokenRefresh else {
            return XCTFail("Did not receive a token refresh observable")
        }
        observable
            .asDriver(onErrorJustReturn: true)
            .drive(observer)
            .disposed(by: disposeBag)
        scheduler.start()
        XCTAssertEqual(expectedResult, observer.events)
    }
}
