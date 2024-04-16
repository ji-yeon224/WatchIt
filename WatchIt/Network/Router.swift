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
}

extension Router: URLRequestConvertible {
    
    private var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    private var endPoint: String {
        switch self {
        case let .trend(type):
            return Endpoint.trending(type: type, time: .week).endpoint
        case let.movieDetail(movieId):
            return Endpoint.detailMovie(movieId: movieId).endpoint
        }
    }
    
    
    private var queryParams: [String: String] {
        switch self {
        case .trend, .movieDetail:
            return ["api_key": APIKey.apiKey, "language": LanguageType.ko.rawValue]
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .trend, .movieDetail:
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
