//
//  Error.swift
//  WatchIt
//
//  Created by 김지연 on 4/13/24.
//

import Foundation
enum NetworkError: Error {
    case responseError
    case connectError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .responseError:
            return "response error!"
        case .connectError:
            return "network error"
        }
    }
}
