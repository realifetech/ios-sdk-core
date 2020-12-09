//
//  GraphNetworkCachePolicy.swift
//  RealifeTech
//
//  Created by Mickey Lee on 04/12/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation
import Apollo

public enum GraphNetworkCachePolicy {
    /// Return data from the cache if available, else fetch results from the server.
    case returnCacheDataElseFetch
    ///  Always fetch results from the server.
    case fetchIgnoringCacheData
    ///  Always fetch results from the server, and don't store these in the cache.
    case fetchIgnoringCacheCompletely
    /// Return data from the cache if available, else return nil.
    case returnCacheDataDontFetch
    /// Return data from the cache if available, and always fetch results from the server.
    case returnCacheDataAndFetch
}

extension GraphNetworkCachePolicy {

    var apolloCachePolicyType: CachePolicy {
        switch self {
        case .returnCacheDataElseFetch:
            return .returnCacheDataElseFetch
        case .fetchIgnoringCacheData:
            return .fetchIgnoringCacheData
        case .fetchIgnoringCacheCompletely:
            return .fetchIgnoringCacheCompletely
        case .returnCacheDataDontFetch:
            return .returnCacheDataDontFetch
        case .returnCacheDataAndFetch:
            return .returnCacheDataAndFetch
        }
    }
}
