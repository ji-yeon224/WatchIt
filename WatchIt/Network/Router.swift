//
//  Router.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import Foundation
import Alamofire

enum Router {
    case trend(type: MediaType)
    case details(type: MediaType, id: Int)
    case credits(type: MediaType, id: Int)
    case topRated(type: MediaType, region: RegionType)
    case nowPlaying(type: MediaType, region: RegionType)
    case search(type: MediaType, region: RegionType?, query: String)
    case thisYearTv(originCountry: RegionType, year: String)

}

extension Router: URLRequestConvertible {
    
    private var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    private var endPoint: String {
        switch self {
        case let .trend(type):
            return Endpoint.trending(type: type, time: .week).endpoint
        case let .details(type, id):
            return Endpoint.details(type: type, id: id).endpoint
        case let .credits(type, id):
            return Endpoint.credits(type: type, id: id).endpoint
        case let .topRated(type, _):
            return Endpoint.topRated(type: type).endpoint
        case let .nowPlaying(type, _):
            return Endpoint.nowPlaying(type: type).endpoint
        case let .search(type, _, _):
            return Endpoint.search(type: type).endpoint
        case .thisYearTv:
            return Endpoint.thisYearTv.endpoint
        }
    }
    
    
    private var queryParams: [String: String] {
        switch self {
        case .trend, .details, .credits:
            return ["api_key": APIKey.apiKey, "language": LanguageType.ko.rawValue]
        case .topRated(_, let region), .nowPlaying(_, let region):
            return ["api_key": APIKey.apiKey, "language": LanguageType.ko.rawValue, "region": region.rawValue]
        case let .search(_, region, query):
            if let region = region {
                return ["api_key": APIKey.apiKey, "language": LanguageType.ko.rawValue, "region": region.rawValue, "query": query]
            } else {
                return ["api_key": APIKey.apiKey, "language": LanguageType.ko.rawValue, "query": query]
            }
        case let .thisYearTv(originCountry, year):
            return ["api_key": APIKey.apiKey, "language": LanguageType.ko.rawValue, "with_origin_country": originCountry.rawValue, "first_air_date_year": year]
            
        }
    }
    
    private var method: HTTPMethod {
        switch self {

        case .trend, .details, .credits, .topRated, .nowPlaying, .search, .thisYearTv:

            return .get
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = try URLRequest(url: url, method: method)
        if method == .get {
            request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(queryParams, into: request)
        }
        return request
    }
    
    
}
