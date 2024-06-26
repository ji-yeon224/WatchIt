//
//  Endpoint.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import Foundation
enum Endpoint {
    case trending(type: MediaType, time: TrendingTime)
    case details(type: MediaType, id: Int)
    case credits(type: MediaType, id: Int)
    case topRated(type: MediaType)
    case nowPlaying(type: MediaType)
    case search(type: MediaType)
    case thisYearTv
    
    var endpoint: String {
        switch self {
        case let .trending(type, time):
            return "/3/trending/\(type.rawValue)/\(time.rawValue)"
        case let .details(type, id):
            return "/3/\(type.rawValue)/\(id)"
        case let .credits(type, id):
            return "/3/\(type.rawValue)/\(id)/credits"
        case let .topRated(type):
            return "/3/\(type.rawValue)/top_rated"
        case let .nowPlaying(type):
            return "/3/\(type.rawValue)/now_playing"

        case let .search(type):
            return "/3/search/\(type.rawValue)"
        case .thisYearTv:
            return "/3/discover/tv"

        }
    }
}
