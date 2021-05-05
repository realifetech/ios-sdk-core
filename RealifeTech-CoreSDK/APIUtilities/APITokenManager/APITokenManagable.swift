//
//  APITokenManagable.swift
//  APIUtilities
//
//  Created by Olivier Butler on 02/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation
import RxSwift

public protocol APITokenManagable {
    var token: String? { get }
    var tokenIsValid: Bool { get }
    var refreshToken: String? { get }
    var refreshTokenIsValid: Bool { get }

    func getValidToken(_: ((Result<Void, Error>) -> Void)?)
    func storeCredentials(accessToken: String, secondsExpiresIn: Int, refreshToken: String?)
    func removeCredentials()
}

struct EmptyTokenManager: APITokenManagable {

    var token: String?
    var tokenIsValid: Bool = false
    var refreshToken: String?
    var refreshTokenIsValid: Bool = false

    func getValidToken(_ completion: ((Result<Void, Error>) -> Void)?) {
        completion?(.success(()))
    }

    func storeCredentials(accessToken: String, secondsExpiresIn: Int, refreshToken: String?) { }

    func removeCredentials() { }
}
