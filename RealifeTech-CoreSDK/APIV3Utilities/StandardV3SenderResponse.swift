//
//  StandardV3SenderResponse.swift
//  CLArena
//
//  Created by Ross Patman on 21/02/2018.
//  Copyright © 2018 ConcertLive. All rights reserved.
//

import Foundation

public struct StandardV3SenderResponse: Codable {
    let code: Int?
    let type: String?
    let message: String?
}

extension StandardV3SenderResponse {
    public var isSuccess: Bool { return code == 200 }
}
