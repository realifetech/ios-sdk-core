//
//  GraphQLDispatcher.swift
//  General
//
//  Created by Jonathon Albert on 09/10/2020.
//  Copyright © 2020 Olivier Butler. All rights reserved.
//

import Foundation
import Apollo

public protocol GraphQLDispatching: AnyObject {
    func dispatch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: GraphNetworkCachePolicy,
        completion: @escaping (Result<GraphQLResult<Query.Data>, Error>) -> Void
    )
    func dispatchMutation<Query: GraphQLMutation>(
        mutation: Query,
        completion:  @escaping (Result<GraphQLResult<Query.Data>, Error>) -> Void
    )
}

public class GraphQLDispatcher: GraphQLDispatching {

    let client: GraphNetwork

    public init(client: GraphNetwork) {
        self.client = client
    }

    public func dispatch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: GraphNetworkCachePolicy,
        completion: @escaping (Result<GraphQLResult<Query.Data>, Error>) -> Void
    ) {
        client.apollo.fetch(query: query, cachePolicy: cachePolicy.apolloCachePolicyType) { result in
            switch result {
            case .success(let graphQLResult):
                return completion(.success(graphQLResult))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }

    public func dispatchMutation<Query: GraphQLMutation>(
        mutation: Query,
        completion:  @escaping (Result<GraphQLResult<Query.Data>, Error>) -> Void
    ) {
        client.apollo.perform(mutation: mutation) { result in
            switch result {
            case .success(let graphQLResult):
                return completion(.success(graphQLResult))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}

extension GraphQLDispatcher: LogEventSending {
    public func logEvent(_ event: AnalyticEvent, completion: @escaping (Result<Bool, Error>) -> Void) {
        let event = ApolloType.AnalyticEvent(
            type: event.type,
            action: event.action,
            new: event.newString,
            old: event.oldString,
            version: event.version,
            timestamp: event.timestampString)
        dispatchMutation(mutation: ApolloType.PutAnalyticEventMutation(input: event), completion: { result in
            switch result {
            case .success(let success):
                return completion(.success(success.data?.putAnalyticEvent.success ?? false))
            case .failure(let error):
                return completion(.failure(error))
            }
        })
    }
}
