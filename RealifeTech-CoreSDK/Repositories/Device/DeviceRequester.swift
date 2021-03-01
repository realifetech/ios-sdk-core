//
//  DeviceRequester.swift
//  CLArena
//
//  Created by Ross Patman on 10/09/2018.
//  Copyright © 2018 ConcertLive. All rights reserved.
//

import Foundation

public struct DeviceRequester: Requester, APIRequester {
    public static var endpoint: String = "/device"
}

extension DeviceRequester {

    static func register(device: Device) -> URLRequest {
        return RequestCreator.createRequest(
            withRoot: root(),
            andEndpoint: endpoint + "/register",
            httpMethod: .POST,
            body: device.jsonRepresentation)
    }

    static func register(tokenForPushNotificationsWithDeviceToken deviceToken: DeviceToken) -> URLRequest {
        var body: [String: Any] = [:]
        body["provider"] = deviceToken.provider ?? ""
        body["providerToken"] = deviceToken.providerToken ?? ""
        return RequestCreator.createRequest(
            withRoot: root(),
            andEndpoint: endpoint + "/me/token",
            httpMethod: .POST,
            body: body)
    }
}
