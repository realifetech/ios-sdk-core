//
//  CoreFactory.swift
//  RealifeTech-CoreSDK
//
//  Created by Mickey Lee on 10/12/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public enum CoreFactory {

    /// Creates DeviceHelper for the current device.
    /// This MUST be called before any other SDK functionality is acessed.
    /// - Returns: UIDeviceInterface protocol
    public static func makeDeviceHelper() -> UIDeviceInterface {
        return UIDeviceFactory.makeUIDeviceHelper()
    }

    /// Creates ReachabilityChecker which detects network connection and Bluetooth state.
    /// - Returns: ReachabilityChecking protocol
    public static func makeReachablitiyChecker() -> ReachabilityChecking {
        return ReachabilityFactory.makeReachabilityHelper()
    }

    /// Setups API with setting the deviceId and configuration to the requesters.
    /// - Parameters:
    ///   - deviceId: Current device UDID set up by UIDeviceInterface protocol
    ///   - configuration: CoreSDK configuration, including appCode, clientSecret and apiUrl
    /// - Returns: APITokenManagable protocol
    public static func makeApiHelper(deviceId: String, configuration: CoreSDKConfiguration) -> APITokenManagable {
        return APIRequesterHelper.setupAPI(
            deviceId: deviceId,
            clientId: configuration.appCode,
            clientSecret: configuration.clientSecret,
            baseUrl: configuration.apiUrl)
    }

    /// Provides the service for GraphQL queries with Apollo client.
    /// - Parameters:
    ///   - configuration: CoreSDK configuration, including graphApiUrlString
    ///   - tokenHelper: APITokenManagable generated by makeApiHelper method
    ///   - deviceId: Current device UDID set up by UIDeviceInterface protocol
    ///   - reachabilityHelper: ReachabilityChecking generated by makeReachablitiyChecker
    /// - Returns: GraphQLDispatching protocol
    public static func makeGraphQLDispatcher(
        configuration: CoreSDKConfiguration,
        tokenHelper: APITokenManagable,
        deviceId: String,
        reachabilityHelper: ReachabilityChecking
    ) -> GraphQLDispatching {
        let client = GraphNetwork(
            graphQLAPIUrl: configuration.graphQLApiUrl,
            tokenHelper: tokenHelper,
            deviceId: deviceId,
            reachabilityHelper: reachabilityHelper)
        return GraphQLDispatcher(client: client)
    }

    /// Requests the valid token from RealifeTech backend service.
    /// This MUST be called before any other SDK functionality is acessed.
    /// - Parameters
    ///  apiHelper: APITokenManagable generated by makeApiHelper
    ///  completion: Optional closure with default nil value
    public static func requestValidToken(
        fromApiHelper apiHelper: APITokenManagable,
        completion: (() -> Void)? = nil
    ) {
        apiHelper.getValidToken(completion)
    }
}
