//
//  DeviceIdHeaderRequestInserting
//  CLArena
//
//  Created by Ross Patman on 04/05/2018.
//  Copyright © 2018 ConcertLive. All rights reserved.
//

import Foundation

public protocol DeviceIdHeaderRequestInserting {
    static func addDeviceIdHeader(toRequest request: URLRequest) -> URLRequest
}

extension DeviceIdHeaderRequestInserting {
    public static func addDeviceIdHeader(toRequest request: URLRequest) -> URLRequest {
        var request = request
        let deviceIdHeader = RequestHeader.generateDeviceIdHeader(deviceId: APIV3RequesterHelper.deviceId)
        request.addValue(deviceIdHeader.valueForHeader, forHTTPHeaderField: deviceIdHeader.header)
        return request
    }
}
