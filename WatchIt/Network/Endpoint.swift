//
//  Endpoint.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import Foundation
enum Endpoint {
    case trending(type: MediaType, time: TrendingTime)
    
    var endpoint: String {
        switch self {
        case let .trending(type, time):
            return "/3/trending/\(type.rawValue)/\(time.rawValue)"
        }
    }
}
