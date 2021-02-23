//
//  APIRequester.swift
//  CLArena
//
//  Created by Ross Patman on 15/02/2018.
//  Copyright © 2018 ConcertLive. All rights reserved.
//

import Foundation
import RxSwift

public protocol APIRequester: JSONContentTypeHeaderRequestInserting, DeviceIdHeaderRequestInserting, OAuthHeaderRequestInserting {
    static func root() -> String
    static func preDispatchAction() -> Observable<Any?>?
    static func interceptors() -> [(URLRequest) -> (URLRequest)]?
    static func dateFormat() -> RequesterDateFormat?
}

extension APIRequester {

    public static func preDispatchAction() -> Observable<Any?>? {
        return .create { observer in
            APIRequesterHelper.tokenManager.getValidToken {
                observer.onNext(())
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    public static func interceptors() -> [(URLRequest) -> (URLRequest)]? {
        return [
            addJSONContentTypeHeader,
            addDeviceIdHeader,
            addOAuthHeader
        ]
    }

    public static func root() -> String {
        return APIRequesterHelper.baseUrl
    }

    public static func dateFormatString() -> String {
        return "yyyy-MM-dd'T'HH:mm:ssZ"
    }

    public static func dateFormat() -> RequesterDateFormat? {
        return .formatted(format: dateFormatString(), localeIdentifier: "en_US_POSIX")
    }
}

extension APIRequester {

    static func format(date: Date, format: String? = nil) -> String {
        let dateFormat = format ?? dateFormatString()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
}
