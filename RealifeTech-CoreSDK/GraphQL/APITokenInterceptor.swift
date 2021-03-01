//
//  APITokenInterceptor.swift
//  RealifeTech-CoreSDK
//
//  Created by Mickey Lee on 02/02/2021.
//

import Foundation
import Apollo

class APITokenInterceptor: ApolloInterceptor {

    let tokenHelper: APITokenManagable

    init(tokenHelper: APITokenManagable) {
        self.tokenHelper = tokenHelper
    }

    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        guard let urlResponse = response?.httpResponse else {
            chain.handleErrorAsync(
                ResponseCodeInterceptor.ResponseCodeError.invalidResponseCode(
                    response: response?.httpResponse,
                    rawData: response?.rawData),
                request: request,
                response: response,
                completion: completion)
            return
        }
        if urlResponse.statusCode == 400 {
            tokenHelper.getValidToken { [self] in
                guard let token = tokenHelper.token, tokenHelper.tokenIsValid else { return }
                request.addHeader(name: "Authorization", value: "Bearer \(token)")
                chain.retry(request: request, completion: completion)
            }
        } else {
            chain.proceedAsync(
                request: request,
                response: response,
                completion: completion)
        }
    }
}
