//
//  RequestLogger.swift
//  CLArena
//
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

internal struct RequestLogger {
    static func log(request: URLRequest) {
        
        #if APILOGGING
        guard let url = request.url else { return }
        print("---")
        print("Request URL: \(String(describing: url))")
        if let body = request.httpBody, let bodyData = try? JSONSerialization.jsonObject(with: body, options: .mutableLeaves) {
            print("Request Body: \(String(describing: bodyData))")
        }
        print("Request Headers: \((String(describing: request.allHTTPHeaderFields ?? [:])))")
        print("---")
        #endif
    }

    static func log(response: HTTPURLResponse, withData data: Data? = nil) {
        #if APILOGGING
        guard let responseURL = response.url else { return }
        print("---")
        print("Response URL: \(String(describing: responseURL))")
        print("Response Status Code: \(String(describing: response.statusCode))")
        if let data = data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
            print("Response Body: \(String(describing: jsonObject))")
        }
        print("---")
        #endif
    }
}
