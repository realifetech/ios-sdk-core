//
//  QueueProviding.swift
//  RealifeTech
//
//  Created by Olivier Butler on 21/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public protocol QueueProviding {

    associatedtype ItemType: Codable

    var next: Result<QueueItem<ItemType>, QueueRetrievalError> { get }
    var count: Int { get }
    var isEmpty: Bool { get }

    func addToQueue(_ items: ItemType)
}

// This stuct allows us to use a generic queue as concrete Type
// Reading
// - https://www.natashatherobot.com/swift-type-erasure/
// - https://robnapier.net/erasure

public struct AnyQueue<ItemType: Codable> {

    private var internalAddToQueue: (_ items: ItemType) -> Void
    private var internalNext: () -> Result<QueueItem<ItemType>, QueueRetrievalError>
    private var internalCount: () -> Int
    private var internalIsEmpty: () -> Bool

    public var next: Result<QueueItem<ItemType>, QueueRetrievalError> { internalNext() }
    public var count: Int { internalCount() }
    public var isEmpty: Bool { internalIsEmpty() }

    public init<Q: QueueProviding>(_ queue: Q) where Q.ItemType == ItemType {
        self.internalAddToQueue = queue.addToQueue
        self.internalNext = { queue.next }
        self.internalCount = { queue.count }
        self.internalIsEmpty = { queue.isEmpty }
    }

    public func addToQueue(_ items: ItemType) {
        internalAddToQueue(items)
    }
}
