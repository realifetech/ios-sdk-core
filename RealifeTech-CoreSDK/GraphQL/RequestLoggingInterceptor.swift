//
//  RequestLoggingInterceptor.swift
//  RealifeTech-CoreSDK
//
//  Created by Mickey Lee on 02/02/2021.
//

import Foundation
import Apollo

class RequestLoggingInterceptor: ApolloInterceptor {

    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        #if APILOGGING
        print("Outgoing request: \(request)")
        print("Response: \(String(describing: response))")
        #endif
        chain.proceedAsync(
            request: request,
            response: response,
            completion: completion)
    }
}
