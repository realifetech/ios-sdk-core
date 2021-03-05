//
//  DiskCacheDataProvidingStrategy.swift
//  RealifeTech-CoreSDK
//
//  Created by Mickey Lee on 05/03/2021.
//

import Foundation

public enum DiskCacheDataProvidingStrategy {
    case localOrRemoteIfExpired
    case localAndRemoteIfExpired
    case localAndRemote
    case localAndForcedRemote
    case remote
    case remoteWithoutCachingResponse
}

public enum DiskCacheDataProvidingError: Error, LocalizedError {

    case directoryNotFound
    case unparseable

    public var errorDescription: String? {
        switch self {
        case .directoryNotFound: return "Direcotry not found".localizedString
        case .unparseable: return "UNPARSEABLE_ERROR".localizedString
        }
    }
}
