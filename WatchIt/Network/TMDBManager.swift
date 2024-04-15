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
    
//    func request<T: Decodable>(api: Router, resultType: T.Type) async throws -> AnyPublisher<T, NetworkError> {
//        let request = AF.request(api)
//        let dataTask = request.serializingDecodable(resultType)
//        
//        switch await dataTask.result {
//        case .success(let result):
//            guard let response = await dataTask.response.response, (200...299).contains(response.statusCode) else {
//                throw NetworkError.responseError
//            }
//            return result
//        case .failure(let error):
//            throw error
//        }
//    }
    
    func request<T: Decodable>(api: Router, resultType: T.Type) -> AnyPublisher<T, NetworkError> {
        AF.request(api)
            .publishDecodable(type: T.self)
            .value()
            .mapError { _ in
                return NetworkError.responseError
            }
            .eraseToAnyPublisher()
        
    }
}
