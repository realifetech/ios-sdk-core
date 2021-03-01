//
//  AuthorisationWorker.swift
//  APIUtilities
//
//  Created by Olivier Butler on 02/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation
import RxSwift

/// Used to request our OAuth token. When new tokens are received, this worker will save them to its store.
protocol AuthorisationWorkable {
    var requestInitialAccessToken: Observable<OAuthToken> { get }
    var refreshAccessToken: Observable<OAuthToken>? { get }
}

struct AuthorisationWorker: AuthorisationWorkable {

    private let authorisationStore: AuthorisationStoring
    private let oAuthRepositoryType: OAuthProviding.Type

    init(
        authorisationStore: AuthorisationStoring,
        oAuthRepositoryType: OAuthProviding.Type = OAuthRepository.self
    ) {
        self.authorisationStore = authorisationStore
        self.oAuthRepositoryType = oAuthRepositoryType
    }

    var requestInitialAccessToken: Observable<OAuthToken> {
        return mapAccessToken(with: oAuthRepositoryType.requestInitialAccessToken())
    }

    var refreshAccessToken: Observable<OAuthToken>? {
        guard
            authorisationStore.accessToken != nil,
            !authorisationStore.accessTokenValid,
            let refreshTokenToSend = authorisationStore.refreshToken
        else {
            return nil
        }
        return mapAccessToken(with: oAuthRepositoryType.refreshAccessToken(refreshTokenToSend))
    }

    private func mapAccessToken(with observable: Observable<OAuthToken>) -> Observable<OAuthToken> {
        return observable
            .map { token in
                if let accessToken = token.accessToken, let expiresIn = token.expiresIn {
                    authorisationStore.saveCredentials(
                        token: accessToken,
                        secondsExpiresIn: expiresIn,
                        refreshToken: token.refreshToken)
                }
                return token
        }
    }
}
