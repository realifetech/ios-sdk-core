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
    /// Deprecated, please use func getValidToken where possible.
    var getTokenObservable: Observable<Void>? { get }

    func getValidToken(_: (() -> Void)?)
}

struct EmptyTokenManager: V3APITokenManagable {

    var token: String?
    var tokenIsValid: Bool = false
    var getTokenObservable: Observable<Void>?

    func getValidToken(_ completion: (() -> Void)?) {
        completion?()
    }
}
