//
//  OAuthToken.swift
//  CLArena
//
//  Created by apple on 13/04/2018.
//  Copyright © 2018 ConcertLive. All rights reserved.
//

import Foundation

struct OAuthToken: Codable {

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case scope
    }

    let accessToken: String?
    let refreshToken: String?
    let expiresIn: Int?
    let tokenType: String?
    let scope: String?
}

extension OAuthToken: Equatable {}
