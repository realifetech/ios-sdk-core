//
//  String+Localization.swift
//  APILayer
//
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

extension String {

    var localizedString: String {
        return NSLocalizedString(
            self,
            tableName: "APILayer",
            bundle: Bundle.apiLayerResourceBundle,
            comment: "")
    }
}

extension Bundle {

    static var apiLayerResourceBundle: Bundle {
        guard
            let path = Bundle(for: APIError.self)
                .path(forResource: "RealifeTech-CoreSDK", ofType: "bundle"),
            let bundle = Bundle(path: path)
        else {
            return .main
        }
        return bundle
    }
}
