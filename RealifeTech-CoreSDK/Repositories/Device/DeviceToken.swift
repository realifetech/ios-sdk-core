//
//  DeviceToken.swift
//  Repositories
//
//  Created by Olivier Butler on 09/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public struct DeviceToken: Codable {

    enum Providers: String {
        case apple = "APPLE"
        case sns = "SNS"
    }
    let provider: String?
    let providerToken: String?

    public static func defaultDeviceToken(withProviderToken providerToken: String) -> DeviceToken {
        return DeviceToken(provider: Providers.apple.rawValue, providerToken: providerToken)
    }
}

public struct TokenRegistrationResponse: Codable {
    static let empty = TokenRegistrationResponse(snsEndpoint: nil)

    let snsEndpoint: String?
}
