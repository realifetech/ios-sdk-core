//
//  OAuthHeaderRequestInserting.swift
//  CLArena
//
//  Created by Ross Patman on 04/05/2018.
//  Copyright © 2018 ConcertLive. All rights reserved.
//

import Foundation

public protocol OAuthHeaderRequestInserting {
    static func addOAuthHeader(toRequest request: URLRequest) -> URLRequest
}

extension OAuthHeaderRequestInserting {
    public static func addOAuthHeader(toRequest request: URLRequest) -> URLRequest {
        var request = request
        guard APIV3RequesterHelper.tokenManager.tokenIsValid, let accessToken = APIV3RequesterHelper.tokenManager.token else { return request }
        let oAuthHeader = RequestHeader.generateAuthHeader(accessToken: accessToken)
        request.addValue(oAuthHeader.valueForHeader, forHTTPHeaderField: oAuthHeader.header)
        return request
    }
}
