//
//  GraphNetwork.swift
//  CLArena
//
//  Created by Jonathon Albert on 19/08/2020.
//  Copyright © 2020 ConcertLive. All rights reserved.
//

import Foundation
import Apollo

public class GraphNetwork {

    let graphQLAPIUrl: URL
    let tokenHelper: V3APITokenManagable
    let deviceId: String
    let reachabilityHelper: ReachabilityChecking

    public init(
        graphQLAPIUrl: URL,
        tokenHelper: V3APITokenManagable,
        deviceId: String,
        reachabilityHelper: ReachabilityChecking
    ) {
        self.graphQLAPIUrl = graphQLAPIUrl
        self.tokenHelper = tokenHelper
        self.deviceId = deviceId
        self.reachabilityHelper = reachabilityHelper
    }

    private lazy var networkTransport: RequestChainNetworkTransport = {
        var headers: [String: String] = ["X-Ls-DeviceId": deviceId]
        if tokenHelper.tokenIsValid, let token = tokenHelper.token {
            headers["Authorization"] = "Bearer \(token)"
        }
        let transport = RequestChainNetworkTransport(
            interceptorProvider: GraphNetworkInterceptorProvider(
                store: store,
                client: URLSessionClient(),
                tokenHelper: tokenHelper),
            endpointURL: graphQLAPIUrl,
            additionalHeaders: headers)
        return transport
    }()

    private lazy var store: ApolloStore = {
        let documentsPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true).first ?? ""
        let documentsUrl = URL(fileURLWithPath: documentsPath)
        let sqliteFileUrl = documentsUrl.appendingPathComponent("realifetech_core_apollo_db.sqlite")
        let sqliteCache = try? SQLiteNormalizedCache(fileURL: sqliteFileUrl)
        return ApolloStore(cache: sqliteCache ?? InMemoryNormalizedCache())
    }()

    private(set) lazy var apollo = ApolloClient(networkTransport: self.networkTransport, store: self.store)
}
