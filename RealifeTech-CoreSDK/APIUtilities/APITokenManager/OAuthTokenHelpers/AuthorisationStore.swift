//
//  UserAuthenticator.swift
//  ConcertLiveCore
//
//  Created by Ross Patman on 06/06/2016.
//  Copyright © 2016 ConcertLive. All rights reserved.
//

import Foundation
import RxSwift

/// Used to store authorisation tokens
protocol AuthorisationStoring {
    var accessToken: String? { get }
    var accessTokenValid: Bool { get }
    var refreshToken: String? { get }
    var refreshTokenValid: Bool { get }

    func saveCredentials(token: String, secondsExpiresIn: Int, refreshToken: String?)
    func removeCredentials()
}

/// Implements a secure (keychain based) storage for token storage
struct AuthorisationStore: AuthorisationStoring {

    enum KeychainKey: String {
        case token = "livestyled-token"
        case expiryDate = "livestyled-tokenExpiryDate"
        case refreshToken = "livestyled-refreshToken"
        case refreshTokenExpiryDate = "livestyled-refreshTokenExpiryDate"
    }

    private let keychain: KeychainSwift

    init(keychain: KeychainSwift = KeychainSwift()) {
        self.keychain = keychain
    }

    var accessToken: String? {
        return keychain.get(KeychainKey.token.rawValue)
    }

    var accessTokenValid: Bool {
        return expiryDateValid(expiryDateString: keychain.get(KeychainKey.expiryDate.rawValue))
    }

    var refreshToken: String? {
        return keychain.get(KeychainKey.refreshToken.rawValue)
    }

    var refreshTokenValid: Bool {
        return expiryDateValid(expiryDateString: keychain.get(KeychainKey.refreshTokenExpiryDate.rawValue))
    }

    func saveCredentials(token: String, secondsExpiresIn: Int, refreshToken: String?) {
        update(accessToken: token, withSecondsExpiresIn: secondsExpiresIn)
        update(refreshToken: refreshToken, withSecondsExpiresIn: secondsExpiresIn)
    }

    func removeCredentials() {
        keychain.delete(KeychainKey.token.rawValue)
        keychain.delete(KeychainKey.expiryDate.rawValue)
        keychain.delete(KeychainKey.refreshToken.rawValue)
        keychain.delete(KeychainKey.refreshTokenExpiryDate.rawValue)
    }

    private func update(accessToken: String, withSecondsExpiresIn seconds: Int) {
        let expiryDate = "\(Date().addingTimeInterval(Double(seconds)).toMilliseconds())"
        keychain.set(accessToken, forKey: KeychainKey.token.rawValue)
        keychain.set(expiryDate, forKey: KeychainKey.expiryDate.rawValue)
    }

    private func update(refreshToken: String?, withSecondsExpiresIn seconds: Int?) {
        guard let refreshToken = refreshToken else { return }
        keychain.set(refreshToken, forKey: KeychainKey.refreshToken.rawValue)
        let nearlyFourteenDaysInSeconds = seconds ?? 1166400
        let expiryDate = "\(Date().addingTimeInterval(Double(nearlyFourteenDaysInSeconds)).toMilliseconds())"
        keychain.set(expiryDate, forKey: KeychainKey.refreshTokenExpiryDate.rawValue)
    }

    private func expiryDateValid(expiryDateString: String?) -> Bool {
        guard let expiryDateString = expiryDateString, let timestamp = Int64(expiryDateString) else { return false }
        return Date().toMilliseconds() < timestamp
    }
}
