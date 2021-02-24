//
//  APIError.swift
//  ConcertLiveCore
//
//  Created by Emal SAIFI on 23/11/2017.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

enum MockErrorType: Int {
    case genericError
}

final class MockAPIError: Error {
    var type: MockErrorType
    
    fileprivate init(type: MockErrorType) {
        self.type = type
    }
    
    static func genericError() -> MockAPIError {
        return MockAPIError(type: .genericError)
    }
}

extension MockAPIError: LocalizedError {
    public var errorDescription: String? {
        switch type {
        case .genericError:
            return NSLocalizedString("UNPARSEABLE_ERROR", comment: "A Generic error")
        }
    }
}

public final class APIError: Error {

    var data: Data?
    var title: String? //probably to be used as an AlertController title
    var message: String? //probably to be used as an AlertController message
    var statusCode: Int?
    var badRequest: Bool { return statusCode == 400 }

    public var clientError: Bool {
        guard let code = statusCode else { return false }
        return code >= 400 && code < 500
    }

    public var unAuthenticated: Bool {
        return statusCode == 401 || statusCode == 403
    }

    var logicError: Bool { //errors which the UI won't show but may need to handle
        return statusCode == 422
    }
    
    static func constructedError(data: Data, statusCode: Int? = nil) -> APIError {
        let error = APIError()
        error.data = data
        error.statusCode = statusCode
        do {
            let errorDictionary = try JSONDecoder().decode([String: String].self, from: data)
            let message = errorDictionary["message"] ?? errorDictionary["error_description"]
            error.title = nil
            error.message = message
        } catch _ {
            error.title = "ERROR".localizedString
            error.message = "UNPARSEABLE_ERROR".localizedString
        }
        return error
    }

    static func constructedError(error: Error) -> APIError {
        if let error = error as? APIError {
            return error
        }
        let newError = APIError()
        newError.message = error.localizedDescription
        return newError
    }

    static func constructedError(title: String?, message: String) -> APIError {
        let error = APIError()
        error.title = title
        error.message = message
        return error
    }

	static func unparseableError() -> APIError {
		let error = APIError()
        error.title = "ERROR".localizedString
		error.message = "UNPARSEABLE_ERROR".localizedString
		return error
	}
}
