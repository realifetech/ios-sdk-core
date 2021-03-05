//
//  RemoteDiskCacheDataProviding.swift
//  RX
//
//  Created by Ross Patman on 21/10/2017.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation
import RxSwift

// Retrieves and automatically manages caching of API responses
public protocol RemoteDiskCacheDataProviding {
    associatedtype Cdble: Codable
    associatedtype Rqstr: Requester

    static var diskCache: DiskCachable { get }
}

public extension RemoteDiskCacheDataProviding {

    static var diskCache: DiskCachable {
        return DiskCache()
    }

    static var diskCacheCodableInterface: DiskCacheCodableInterface {
        return DiskCacheCodableInterface(diskCache: diskCache)
    }

    static func items(
        forRequest request: URLRequest = Rqstr.request(forId: nil),
        strategy: DiskCacheDataProvidingStrategy = .localOrRemoteIfExpired
    ) -> Observable<[Cdble]> {
        return retrieve(
            type: [Cdble].self,
            forRequest: request,
            strategy: strategy)
    }

    static func item(
        forRequest request: URLRequest,
        strategy: DiskCacheDataProvidingStrategy = .localOrRemoteIfExpired
    ) -> Observable<Cdble> {
        return retrieve(
            type: Cdble.self,
            forRequest: request,
            strategy: strategy)
    }

    static func retrieve<Model: Codable>(
        type: Model.Type,
        forRequest request: URLRequest = Rqstr.request(forId: nil),
        privateObj: Bool = false,
        strategy: DiskCacheDataProvidingStrategy = .localOrRemoteIfExpired
    ) -> Observable<Model> {
        let fileName = privateObj ? request.identifier + DiskCache.privateIndicator : request.identifier
        let theRemote = remote(
            of: type.self,
            forRequest: request,
            ignoreSystemCache: strategy == .localAndForcedRemote)
            .do(onNext: {
                if strategy != .remoteWithoutCachingResponse {
                    saveToDiskCache($0, with: fileName)
                }
            })

        switch strategy {
        case .localOrRemoteIfExpired:
            guard let theLocal = local(of: type.self, fileName: fileName).object else { return theRemote }
            return theLocal
        case .localAndRemoteIfExpired, .localAndRemote, .localAndForcedRemote:
            let cacheResponse = local(of: type.self, fileName: fileName, includeExpired: true)
            guard let theLocal = cacheResponse.object else { return theRemote }
            if
                strategy == .localAndRemote ||
                strategy == .localAndForcedRemote ||
                cacheResponse.expired {
                return .concat(theLocal, theRemote)
            } else {
                return theLocal
            }
        case .remote, .remoteWithoutCachingResponse:
            return theRemote
        }
    }

    private static func local<Model: Codable>(
        of type: Model.Type,
        fileName: String,
        includeExpired: Bool = false
    ) -> (object: Observable<Model>?, expired: Bool) {
        let local = diskCacheCodableInterface.local(
            of: type,
            fileName: fileName,
            includeExpired: includeExpired,
            dateFormat: Rqstr.dateFormat())
        guard let localObject = local.object else {
            return (object: nil, expired: false)
        }
        return (object: .just(localObject), expired: local.expired)
    }

    private static func remote<Model: Codable>(
        of type: Model.Type,
        forRequest request: URLRequest,
        ignoreSystemCache: Bool = false
    ) -> Observable<Model> {
        var request = request
        if ignoreSystemCache {
            request.cachePolicy = .reloadIgnoringLocalCacheData
        }
        return Rqstr.response(forRequest: request).map { data in
            return try diskCacheCodableInterface.decode(
                data: data,
                to: Model.self,
                dateFormat: Rqstr.dateFormat())
        }
    }

    private static func saveToDiskCache<Model: Codable>(_ model: Model, with fileName: String) {
        try? diskCacheCodableInterface.save(model, with: fileName, canFileBeExpired: true)
    }
}
