//
//  Date+Formatted.swift
//  RealifeTech-CoreSDK
//
//  Created by Mickey Lee on 09/12/2020.
//

import Foundation

extension Date {

    var rltFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        return formatter.string(from: self)
    }
}
