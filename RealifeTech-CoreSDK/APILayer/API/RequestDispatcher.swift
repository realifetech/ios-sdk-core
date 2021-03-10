//
//  RequestDispatcher.swift
//  RX
//
//  Created by Ross Patman on 22/10/2017.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public struct RequestDispatcher {

    static func dispatch(request: URLRequest) -> Observable<Data> {
        RequestLogger.log(request: request)
        return URLSession.shared.rx.response(request: request)
            .flatMap({ (tuple: (response: URLResponse, data: Data)) -> Observable<Data> in
                let (response, data) = tuple
                if let response = response as? HTTPURLResponse {
                    RequestLogger.log(response: response, withData: data)
                    if 200 ..< 300 ~= response.statusCode {
                        return .just(data)
                    } else {
                        return .error(APIError.constructedError(data: data, statusCode: response.statusCode))
                    }
                } else {
                    return .error(APIError.unparseableError())
                }
            })
            .do(onNext: { (_) in
                RequestTimeLogger.shared.removeRequest(withIdentifier: request.identifier)
            }, onError: { (_) in
                RequestTimeLogger.shared.removeRequest(withIdentifier: request.identifier)
            }, onSubscribe: {
                RequestTimeLogger.shared.addRequest(withIdentifier: request.identifier)
            })
    }
}
