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
    
    
    func request<T: ResponseProtocol>(api: Router, resultType: T.Type) async throws -> any ModelTypeProtocol {
        
        let request = AF.request(api)
        let dataTask = request.serializingDecodable(T.self)
        switch await dataTask.result {
        case .success(let response):
            return response.toDomain()
        case .failure(let error):
            debugPrint(error.localizedDescription)
            throw NetworkError.responseError
        }
        
    }
}
