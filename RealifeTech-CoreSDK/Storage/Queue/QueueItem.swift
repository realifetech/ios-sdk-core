//
//  QueueItem.swift
//  RealifeTech
//
//  Created by Olivier Butler on 21/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public struct QueueItem<Item: Codable> {

    public let item: Item
    public let releaseQueue: (_: QueueAction) -> Void

    public init(item: Item, releaseQueue: @escaping (_: QueueAction) -> Void) {
        self.item = item
        self.releaseQueue = releaseQueue
    }
}
