//
//  String+RequestIdentifier.swift
//  RealifeTech-CoreSDK
//
//  Created by Mickey Lee on 05/03/2021.
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
