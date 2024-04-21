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
    case movieDetail(movieId: Int)
    case credits(type: MediaType, id: Int)
    case topRated(type: MediaType, region: RegionType)
    
}

extension Router: URLRequestConvertible {
    
    private var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    private var endPoint: String {
        switch self {
        case let .trend(type):
            return Endpoint.trending(type: type, time: .week).endpoint
        case let .movieDetail(movieId):
            return Endpoint.detailMovie(movieId: movieId).endpoint
        case let .credits(type, id):
            return Endpoint.credits(type: type, id: id).endpoint
        case let .topRated(type, _):
            return Endpoint.topRated(type: type).endpoint
        }
    }
    
    
    private var queryParams: [String: String] {
        switch self {
        case .trend, .movieDetail, .credits:
            return ["api_key": APIKey.apiKey, "language": LanguageType.ko.rawValue]
        case let .topRated(_, region):
            return ["api_key": APIKey.apiKey, "language": LanguageType.ko.rawValue, "region": region.rawValue]
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .trend, .movieDetail, .credits, .topRated:
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
