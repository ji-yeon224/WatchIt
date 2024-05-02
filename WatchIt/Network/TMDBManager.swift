//
//  TMDBManager.swift
//  WatchIt
//
//  Created by 김지연 on 4/13/24.
//

import Foundation
import Alamofire
import Combine

final class TMDBManager {
    static let shared = TMDBManager()
    private init() { }
   
    
    func request<T: ResponseProtocol>(api: Router, resultType: T.Type) -> AnyPublisher<any ModelTypeProtocol, NetworkError> {
        AF.request(api)
            .publishDecodable(type: T.self)
            .value()
            .map {
                return $0.toDomain()
            }
            .mapError { error in
                debugPrint(error)
                return NetworkError.responseError
            }
            .eraseToAnyPublisher()
        
    }
}
