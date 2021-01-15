//
//  String+Localization.swift
//  APILayer
//
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

extension String {
    var localizedString: String {
        var localizedString = ""
        localizedString = NSLocalizedString(self, tableName: "Accessibility", bundle: Bundle.main, comment: "")
        if localizedString != self { return localizedString }
        return NSLocalizedString(self, tableName: "APILayer", bundle: Bundle.main, comment: "")
    }
}
