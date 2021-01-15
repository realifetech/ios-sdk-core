//
//  RequestCreator.swift
//  RX
//
//  Created by Ross Patman on 18/09/2017.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation
import CryptoKit

extension String {
    var md5: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

public extension URLRequest {
    var identifier: String {
        guard let url = url else { return "" }
        var string = url.absoluteString
        if let httpMethod = httpMethod { string += httpMethod }
        if let allHTTPHeaderFields = allHTTPHeaderFields {
            let safeHeaderFields = allHTTPHeaderFields
                .filter { return $0.key != "Authorization" }
                .sorted { $0.key < $1.key }
                .map { "\($0.key)=\($0.value)" }
                .joined(separator: ",")
            string += safeHeaderFields.description
        }
        if let httpBody = httpBody, let bodyString = String(data: httpBody, encoding: .utf8) { string += bodyString }
        return string.md5
    }
}

public enum HttpMethod: String {
    case GET, PUT, POST, DELETE, PATCH
}

public protocol RequestRootURL {
    var rawValue: String { get }
}

public struct RequestCreator {

    static func path(withRoot root: RequestRootURL, andEndpoint endpoint: String) -> String {
        return "\(root.rawValue)\(endpoint)"
    }

    static func path(withRoot root: String, andEndpoint endpoint: String) -> String {
        return "\(root)\(endpoint)"
    }

    public static func createRequest(withRoot root: String, andEndpoint endpoint: String, httpMethod: HttpMethod, body: [String: Any]? = nil, bodyData: Data? = nil, headers: [String: String]? = nil) -> URLRequest {
        let urlString = path(withRoot: root, andEndpoint: endpoint)
        var req = URLRequest(url: URL(string: urlString)!, timeoutInterval: 30)
        req.httpMethod = httpMethod.rawValue
        if let body = body {
            if httpMethod == .GET {
                req.url = URL(string: "\(urlString)\(addGETParameters(fromBody: body))")
            } else {
                if let bodyData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) {
                    req.httpBody = bodyData
                }
            }
        }
        if let bodyData = bodyData {
            req.httpBody = bodyData
        }
        if let headers = headers {
            for header in headers {
                req.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        return req
    }

    public static func createRequest(withRoot root: RequestRootURL, andEndpoint endpoint: String, httpMethod: HttpMethod, body: [String: Any]? = nil, bodyData: Data? = nil, headers: [String: String]? = nil) -> URLRequest {
        let urlString = path(withRoot: root, andEndpoint: endpoint)
        var req = URLRequest(url: URL(string: urlString)!, timeoutInterval: 30)
        req.httpMethod = httpMethod.rawValue
        if let body = body {
            if httpMethod == .GET {
                req.url = URL(string: "\(urlString)\(addGETParameters(fromBody: body))")
            } else {
                if let bodyData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) {
                    req.httpBody = bodyData
                }
            }
        }
        if let bodyData = bodyData {
            req.httpBody = bodyData
        }
        if let headers = headers {
            for header in headers {
                req.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        return req
    }

    static func addGETParameters(fromBody body: [String: Any]) -> String {
        var urlParams = "?"
        let params = body.map { (key, value) -> (String, Any) in
            return (key, value)
            }.sorted { $0.key < $1.key }
        for parameter in params {
            let key = parameter.key
            if let valueArray = parameter.value as? [String] {
                for value in valueArray {
                    urlParams += "\(key)=\(value.safelyUrlEncoded)&"
                }
            } else if let paramString = parameter.value as? String {
                urlParams += "\(key)=\(paramString.safelyUrlEncoded)&"
            } else {
                urlParams += "\(key)=\(parameter.value)&"
            }
        }
        return urlParams
    }
}

private extension String {
    var safelyUrlEncoded: String {
        var urlEncodedCharSet: CharacterSet = .urlHostAllowed
        urlEncodedCharSet.remove("+")
        return addingPercentEncoding(withAllowedCharacters: urlEncodedCharSet) ?? ""
    }
}
