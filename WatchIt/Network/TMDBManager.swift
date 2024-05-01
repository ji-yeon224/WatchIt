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
   
    
    func request<T: Decodable>(api: Router, resultType: T.Type) -> AnyPublisher<T, NetworkError> {
        AF.request(api)
            .publishDecodable(type: T.self)
            .value()
            .mapError { error in
                print(error)
                return NetworkError.responseError
            }
            .eraseToAnyPublisher()
        
    }
}
