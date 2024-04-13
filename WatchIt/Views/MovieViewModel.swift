//
//  MovieViewModel.swift
//  WatchIt
//
//  Created by 김지연 on 4/13/24.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    private var cancellable: Set<AnyCancellable> = []
    func getTrendList() {
        TMDBManager.shared.request(api: .trend(type: .movie), resultType: TrendsResDto.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { result in
                print(result)
            }
            .store(in: &cancellable)
    }
}
