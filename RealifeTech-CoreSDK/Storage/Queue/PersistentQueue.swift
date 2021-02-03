//
//  PersistantQueue.swift
//  RealifeTech
//
//  Created by Olivier Butler on 20/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public class PersistentQueue<Queue: Codable & Identifiable>: QueueProviding {

    // MARK: - Private Implementation

    private var locked: Bool = false
    private var queue: [Queue] = []

    private let storage: Storeable

    public init(name: String, storage: Storeable? = nil) {
        self.storage = storage ?? CodableStore(
            storage: DiskStorage(path: URL(fileURLWithPath: NSTemporaryDirectory())),
            storagePrefix: name)
        guard let storedQueue: [Queue] = try? self.storage.fetchAll() else { return }
        queue = storedQueue
    }

    /// Provides an item from the queue. Calling will lock the queue
    private func getNextQueueItem() -> Result<QueueItem<Queue>, QueueRetrievalError> {
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

    public var next: Result<QueueItem<Queue>, QueueRetrievalError> { getNextQueueItem() }
    public var count: Int { queue.count }
    public var isEmpty: Bool { queue.isEmpty }

    public func addToQueue(_ item: Queue) {
        try? storage.save(item, for: item.uniqueId.uuidString)
        queue.append(item)
    }
}
