//
//  CoreSDKConfiguration.swift
//  RealifeTech-CoreSDK
//
//  Created by Mickey Lee on 10/12/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public struct CoreSDKConfiguration {

    public let appCode: String
    public let clientSecret: String
    public let apiUrl: String
    public let graphQLApiUrlString: String

    static let defaultApiUrl: String =  "https://api.livestyled.com/v3"
    static let defaultGraphQLApiUrl: String = "https://graphql-eu.realifetech.com"

    /// - Parameter appCode: String used to identify the application which uses the RealifeTech SDK
    /// - Parameter clientSecret: String which is used to authenticate with the RealifeTech backend
    /// - Parameter apiUrl: [Optional] Provide a string value of a URL to override the SDK default
    /// - Parameter graphApiUrl: [Optional] Provide a string value of a URL to override the SDK default
    public init(appCode: String, clientSecret: String, apiUrl: String? = nil, graphQLApiUrl: String? = nil) {
        self.appCode = appCode
        self.clientSecret = clientSecret
        self.apiUrl = apiUrl ?? CoreSDKConfiguration.defaultApiUrl
        self.graphQLApiUrlString = graphQLApiUrl ?? CoreSDKConfiguration.defaultGraphQLApiUrl
    }
}

extension CoreSDKConfiguration {

    var graphQLApiUrl: URL { URL(string: graphQLApiUrlString) ?? URL(fileURLWithPath: "") }
}
