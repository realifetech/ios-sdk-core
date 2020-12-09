//
//  Identifiable.swift
//  RealifeTech
//
//  Created by Olivier Butler on 21/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

protocol Identifiable {
    var uniqueId: UUID { get }
}
