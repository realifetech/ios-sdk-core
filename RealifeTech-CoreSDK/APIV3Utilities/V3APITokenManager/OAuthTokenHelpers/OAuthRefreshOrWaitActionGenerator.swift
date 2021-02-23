//
//  OAuthRefreshOrWaitActionGenerator.swift
//  CLArena
//
//  Created by Ross Patman on 29/05/2019.
//  Copyright © 2019 ConcertLive. All rights reserved.
//

import Foundation
import RxSwift

protocol OAuthRefreshOrWaitActionGenerating {
    var refreshTokenOrWaitAction: Observable<Void>? { get }
}

/// Ensures we only make a new request when one is required
struct OAuthRefreshOrWaitActionGenerator: OAuthRefreshOrWaitActionGenerating {

    private let authorisationWorker: AuthorisationWorkable
    private let authorisationStore: AuthorisationStoring
    private let oAuthTokenRefreshWatcher: OAuthTokenRefreshWatchable

    init (authorisationWorker: AuthorisationWorkable, oAuthTokenRefreshWatcher: OAuthTokenRefreshWatchable, authorisationStore: AuthorisationStoring) {
        self.authorisationWorker = authorisationWorker
        self.authorisationStore = authorisationStore
        self.oAuthTokenRefreshWatcher = oAuthTokenRefreshWatcher
    }

    /// Nil if we have a valid token. If no token exists, or is invalid, or is being currently refreshed, this will return an observable which will emit once the token action is complete.
    var refreshTokenOrWaitAction: Observable<Void>? {
        if let ongoingTokenRefresh = oAuthTokenRefreshWatcher.ongoingTokenRefresh {
            // We take 1 because we only care about the current refresh.
            return ongoingTokenRefresh.take(1).map { _ in return () }
        } else if authorisationStore.accessTokenValid {
            return nil
        }
        oAuthTokenRefreshWatcher.updateRefreshingStatus(newValue: .refreshing)
        let refresh = authorisationWorker.refreshAccessToken ?? authorisationWorker.requestInitialAccessToken
        return refresh
            .take(1)
            .do(onNext: { _ in
                self.oAuthTokenRefreshWatcher.updateRefreshingStatus(newValue: .valid)
            }, onError: { _ in
                self.oAuthTokenRefreshWatcher.updateRefreshingStatus(newValue: .invalid)
            })
            .map { _ in return () }
            .catchError { _ in return Observable.just(()) }
    }
}
