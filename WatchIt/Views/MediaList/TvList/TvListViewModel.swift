//
//  TvListViewModel.swift
//  WatchIt
//
//  Created by 김지연 on 4/21/24.
//

import Foundation
import Combine

final class TvListViewModel: ViewModelProtocol {
    
    private var cancellable: Set<AnyCancellable> = []
    @Published var tvTrendData: [MediaItem] = []
    @Published var tvTopRated: [MediaItem] = []
    
    enum Action {
        case tvTrend
        case tvTopRated
    }
    
    func action(_ action: Action) {
        switch action {
        case .tvTrend:
            getTrendData()
        case .tvTopRated:
            getTopRated()
        }
    }
    
    private func getTrendData() {
        TMDBManager.shared.request(api: .trend(type: .tv), resultType: TvListDto.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { result in
                self.tvTrendData = result.results.map { $0.toDomain() }
            }
            .store(in: &cancellable)

    }
    
    private func getTopRated() {
        TMDBManager.shared.request(api: .topRated(type: .tv, region: nil), resultType: TvListDto.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { result in
                self.tvTopRated = result.results.map { $0.toDomain() }
            }
            .store(in: &cancellable)

    }
}
