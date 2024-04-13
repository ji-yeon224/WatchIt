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
}

extension Router: URLRequestConvertible {
    
    private var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    private var endPoint: String {
        switch self {
        case let .trend(type):
            return Endpoint.trending(type: type, time: .week).endpoint
        }
    }
    
    
    private var queryParams: [String: String] {
        switch self {
        case .trend:
            return ["api_key": APIKey.apiKey, "language": LanguageType.ko.rawValue]
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .trend(let type):
            return .get
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var request = try URLRequest(url: url, method: method)
        if method == .get {
            request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(queryParams, into: request)
        }
        return request
    }
    
    
}
