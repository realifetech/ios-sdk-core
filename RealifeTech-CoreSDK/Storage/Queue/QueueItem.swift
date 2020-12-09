//
//  QueueItem.swift
//  RealifeTech
//
//  Created by Olivier Butler on 21/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

struct QueueItem <T: Codable> {
    let item: T
    let releaseQueue: (_: QueueAction) -> Void
}
