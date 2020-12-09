//
//  OAuthSender.swift
//  CLArena
//
//  Created by apple on 13/04/2018.
//  Copyright © 2018 ConcertLive. All rights reserved.
//

import Foundation
import RxSwift

protocol OAuthProviding {
    static func requestInitialAccessToken() -> Observable<OAuthToken>
}

struct OAuthRepository: RemoteDiskCacheDataProviding {
    typealias Cdble = OAuthToken
    typealias Rqstr = OAuthRequester
}

extension OAuthRepository: OAuthProviding {
    static func requestInitialAccessToken() -> Observable<OAuthToken> {
        return retrieve(type: Cdble.self, forRequest: Rqstr.requestInitialAccessToken(), strategy: .remoteWithoutCachingResponse)
    }
}
