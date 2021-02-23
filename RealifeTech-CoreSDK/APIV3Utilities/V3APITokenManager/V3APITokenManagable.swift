//
//  EnvironmentVariables.swift
//  APIUtilities
//
//  Created by Olivier Butler on 02/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation
import RxSwift

public protocol V3APITokenManagable {
    var token: String? { get }
    var tokenIsValid: Bool { get }
    var refreshToken: String? { get }
    var refreshTokenIsValid: Bool { get }

    func getValidToken(_: (() -> Void)?)
    func storeCredentials(accessToken: String, secondsExpiresIn: Int, refreshToken: String?)
    func removeCredentials()
}

struct EmptyTokenManager: V3APITokenManagable {

    var token: String?
    var tokenIsValid: Bool = false
    var refreshToken: String?
    var refreshTokenIsValid: Bool = false

    func getValidToken(_ completion: (() -> Void)?) {
        completion?()
    }

    func storeCredentials(accessToken: String, secondsExpiresIn: Int, refreshToken: String?) { }

    func removeCredentials() { }
}
