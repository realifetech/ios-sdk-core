//
//  APITokenManager.swift
//  APIUtilities
//
//  Created by Olivier Butler on 05/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation
import RxSwift

public class APITokenManager: APITokenManagable {

    public var token: String? { authorisationStore.accessToken }
    public var tokenIsValid: Bool { authorisationStore.accessTokenValid }
    public var refreshToken: String? { authorisationStore.refreshToken }
    public var refreshTokenIsValid: Bool { authorisationStore.refreshTokenValid }

    private let authorisationStore: AuthorisationStoring
    private let oAuthRefreshOrWaitActionGenerator: OAuthRefreshOrWaitActionGenerating
    private let scheduler: SchedulerType
    private let disposeBag: DisposeBag = DisposeBag()

    init(
        authorisationStore: AuthorisationStoring,
        oAuthRefreshOrWaitActionGenerator: OAuthRefreshOrWaitActionGenerating,
        subscibeOnScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)
    ) {
        self.scheduler = subscibeOnScheduler
        self.authorisationStore = authorisationStore
        self.oAuthRefreshOrWaitActionGenerator = oAuthRefreshOrWaitActionGenerator
    }

    public func getValidToken(_ completion: (() -> Void)?) {
        guard let getTokenObservable = oAuthRefreshOrWaitActionGenerator.refreshTokenOrWaitAction else {
            completion?()
            return
        }
        getTokenObservable
            .subscribeOn(scheduler)
            .observeOn(MainScheduler.instance)
            .take(1)
            .subscribe(onNext: { _ in
                completion?()
            })
            .disposed(by: disposeBag)
    }

    public func storeCredentials(accessToken: String, secondsExpiresIn: Int, refreshToken: String?) {
        authorisationStore.saveCredentials(
            token: accessToken,
            secondsExpiresIn: secondsExpiresIn,
            refreshToken: refreshToken)
    }

    public func removeCredentials() {
        authorisationStore.removeCredentials()
    }
}
