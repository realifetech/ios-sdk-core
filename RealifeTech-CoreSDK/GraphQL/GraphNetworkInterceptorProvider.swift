//
//  GraphNetworkInterceptorProvider.swift
//  RealifeTech-CoreSDK
//
//  Created by Mickey Lee on 02/02/2021.
//

import Foundation
import Apollo

struct GraphNetworkInterceptorProvider: InterceptorProvider {

    let store: ApolloStore
    let client: URLSessionClient
    let tokenHelper: V3APITokenManagable

    func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        return [
            LegacyCacheReadInterceptor(store: store),
            NetworkFetchInterceptor(client: client),
            RequestLoggingInterceptor(),
            APIV3TokenInterceptor(tokenHelper: tokenHelper),
            ResponseCodeInterceptor(),
            LegacyParsingInterceptor(cacheKeyForObject: store.cacheKeyForObject),
            LegacyCacheWriteInterceptor(store: store)
        ]
    }
}
