//
//  MovieViewModel.swift
//  WatchIt
//
//  Created by 김지연 on 4/13/24.
//

import Foundation
import Combine

final class MovieTrendViewModel: ViewModelProtocol {
    
    private var cancellable: Set<AnyCancellable> = []
    @Published var state: State
    
    enum Action {
        case getMovieTrend
    }
    
    enum State {
        case trendData([MovieTrend])
    }
    
    func action(_ action: Action) {
        switch action {
        case .getMovieTrend:
            getTrendList()
        }
    }
    
    init() {
        state = .trendData([])
    }
    
    
    
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
                let data = result.results
                self.state = .trendData(data.map { $0.toDomain() })
            }
            .store(in: &cancellable)
    }
}
