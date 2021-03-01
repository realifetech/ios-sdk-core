//
//  DefaultDiskCacheStrategyProviding.swift
//  CLArena
//
//  Created by Ross Patman on 21/11/2018.
//  Copyright © 2018 ConcertLive. All rights reserved.
//

import Foundation
import RxSwift

protocol DefaultDiskCacheStrategyProviding { }

private extension Bool {
    var diskCacheDataProvidingStrategy: DiskCacheDataProvidingStrategy {
        return self ? .localAndForcedRemote : .localAndRemote
    }
}

extension DefaultDiskCacheStrategyProviding where Self: RemoteDiskCacheDataProviding {
    static func retrieve<Model: Codable>(
        type: Model.Type,
        forRequest request: URLRequest = Rqstr.request(forId: nil),
        privateObj: Bool = false,
        forceUpdate: Bool = false
    ) -> Observable<Model> {
        return retrieve(
            type: type,
            forRequest: request,
            privateObj: privateObj,
            strategy: forceUpdate.diskCacheDataProvidingStrategy)
    }
}
