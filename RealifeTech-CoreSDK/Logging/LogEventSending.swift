//
//  LogEventSending.swift
//  General
//
//  Created by Jonathon Albert on 16/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public protocol LogEventSending {
    func logEvent(_ event: AnalyticEvent, completion: @escaping (Result<Bool, Error>) -> Void)
}
