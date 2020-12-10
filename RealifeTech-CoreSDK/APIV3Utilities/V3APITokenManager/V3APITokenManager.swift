//
//  V3APITokenManager.swift
//  APIUtilities
//
//  Created by Olivier Butler on 05/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation
import RxSwift

public class V3APITokenManager: V3APITokenManagable {

    public var token: String? { authorisationStore.accessToken }
    public var tokenIsValid: Bool { authorisationStore.accessTokenValid }
    public var getTokenObservable: Observable<Void>? {
        oAuthRefreshOrWaitActionGenerator.refreshTokenOrWaitAction
    }

    private let authorisationStore: AuthorisationStoring
    private let oAuthRefreshOrWaitActionGenerator: OAuthRefreshOrWaitActionGenerating
    private let scheduler: SchedulerType
    private let disposeBag: DisposeBag = DisposeBag()

    init(authorisationStore: AuthorisationStoring, oAuthRefreshOrWaitActionGenerator: OAuthRefreshOrWaitActionGenerating, subscibeOnScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
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
}
