//
//  QueueItem.swift
//  RealifeTech
//
//  Created by Olivier Butler on 21/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public struct QueueItem <T: Codable> {

    public let item: T
    public let releaseQueue: (_: QueueAction) -> Void

    public init(item: T, releaseQueue: @escaping (_: QueueAction) -> Void) {
        self.item = item
        self.releaseQueue = releaseQueue
    }
}
