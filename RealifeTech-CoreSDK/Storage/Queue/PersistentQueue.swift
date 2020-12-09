//
//  PersistantQueue.swift
//  RealifeTech
//
//  Created by Olivier Butler on 20/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

class PersistentQueue<T: Codable & Identifiable>: QueueProviding {

    // MARK: - Private Implementation

    private var locked: Bool = false
    private var queue: [T] = []

    private let storage: CodableStorageProtocol

    init(name: String, storage: CodableStorageProtocol? = nil) {
        self.storage = storage ?? CodableStorage(
            storage: DiskStorage(path: URL(fileURLWithPath: NSTemporaryDirectory())),
            storagePrefix: name)
        guard let storedQueue: [T] = try? self.storage.fetchAll() else { return }
        queue = storedQueue
    }

    /// Provides an item from the queue. Calling will lock the queue
    private func getNextQueueItem() -> Result<QueueItem<T>, QueueRetrievalError> {
        if locked {
            return .failure(.queueIsLocked)
        } else if let nextItem = queue.first {
            locked = true
            let nextQueueItem = QueueItem(item: nextItem, releaseQueue: finishCurrentItem)
            return(.success(nextQueueItem))
        } else {
            return .failure(.empty)
        }
    }

    private func finishCurrentItem(_ action: QueueAction) {
        switch action {
        case .removeFirst:
            guard !queue.isEmpty else { return }
            let currentItem = queue.removeFirst()
            storage.delete(key: currentItem.uniqueId.uuidString)
        case .sendFirstToBack:
            let frontOfQueue = queue.removeFirst()
            queue.append(frontOfQueue)
        case .doNothing:
            break
        }
        locked = false
    }

    // MARK: - Queue Providing

    var next: Result<QueueItem<T>, QueueRetrievalError> { getNextQueueItem() }
    var count: Int { queue.count }
    var isEmpty: Bool { queue.isEmpty }

    func addToQueue(_ item: T) {
        try? storage.save(item, for: item.uniqueId.uuidString)
        queue.append(item)
    }
}
