//
//  DeviceRepository.swift
//  CLArena
//
//  Created by apple on 25/11/2018.
//  Copyright © 2018 ConcertLive. All rights reserved.
//

import Foundation
import RxSwift

public protocol DeviceProviding {

    static func registerDevice(_ device: Device) -> Observable<Bool>

    static func registerForPushNotifications(
        with deviceToken: DeviceToken
    ) -> Observable<TokenRegistrationResponse>
}

public struct DeviceRepository: RemoteDiskCacheDataProviding {

    public typealias Cdble = StandardSenderResponse
    public typealias Rqstr = DeviceRequester
}

extension DeviceRepository: DeviceProviding {

    public static func registerDevice(_ device: Device) -> Observable<Bool> {
        return retrieve(
            type: StandardSenderResponse.self,
            forRequest: Rqstr.register(device: device),
            strategy: .remoteWithoutCachingResponse).map { $0.isSuccess }
    }

    public static func registerForPushNotifications(
        with deviceToken: DeviceToken
    ) -> Observable<TokenRegistrationResponse> {
        return retrieve(
            type: TokenRegistrationResponse.self,
            forRequest: Rqstr.register(tokenForPushNotificationsWithDeviceToken: deviceToken),
            strategy: .remoteWithoutCachingResponse)
    }
}
