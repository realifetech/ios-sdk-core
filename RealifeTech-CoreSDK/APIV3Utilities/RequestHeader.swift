//
//  RequestHeader.swift
//  ConcertLiveCore
//
//  Created by J.Albert on 13/06/2017.
//  Copyright © 2017 J.Albert. All rights reserved.
//

import Foundation

public struct RequestHeader {

    private enum HeaderKeys: String {
        case deviceId = "X-Ls-DeviceId"
        case authorization = "Authorization"
        case bearerAuthorization = "Bearer"
    }

    var header: String
    var valueForHeader: String

    public static func generateDeviceIdHeader(deviceId: String) -> RequestHeader {
        return RequestHeader(header: HeaderKeys.deviceId.rawValue, valueForHeader: deviceId)
    }

    public static func generateAuthHeader(accessToken: String) -> RequestHeader {
        return RequestHeader(header: HeaderKeys.authorization.rawValue, valueForHeader: "\(HeaderKeys.bearerAuthorization.rawValue) \(accessToken)")
    }
}
