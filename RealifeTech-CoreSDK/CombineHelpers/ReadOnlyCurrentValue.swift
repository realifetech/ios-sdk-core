//
//  ReadOnlyCurrentValue.swift
//  RealifeTech
//
//  Created by Olivier Butler on 26/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation
import Combine

public struct ReadOnlyCurrentValue<T> {

    public var value: T { return currentValueSubject.value }

    private let currentValueSubject: CurrentValueSubject<T, Never>

    public init(from currentValueSubject: CurrentValueSubject<T, Never>) {
        self.currentValueSubject = currentValueSubject
    }
}
