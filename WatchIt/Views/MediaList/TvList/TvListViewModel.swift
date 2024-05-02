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
    @Published var thisYearTv: [MediaItem] = []
    
    enum Action {
        case tvTrend
        case tvTopRated
        case thisYear
    }
    
    func action(_ action: Action) {
        switch action {
        case .tvTrend:
            getTrendData()
        case .tvTopRated:
            getTopRated()
        case .thisYear:
            getThisYearTv()
        }
    }
    
    private func getTrendData() {
        TMDBManager.shared.request(api: .trend(type: .tv), resultType: TvListResDto.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { result in
                if let result = result as? MediaItemList {
                    self.tvTrendData = result.results
                }
//                self.tvTrendData = result.toDomain().results //result.results.map { $0.toDomain() }
            }
            .store(in: &cancellable)

    }
    
    private func getTopRated() {
        TMDBManager.shared.request(api: .topRated(type: .tv, region: .kr), resultType: TvListResDto.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { result in
                if let result = result as? MediaItemList {
                    self.tvTopRated = result.results
                }
//                self.tvTopRated = result.toDomain().results //result.results.map { $0.toDomain() }
            }
            .store(in: &cancellable)

    }
    
    private func getThisYearTv() {
        TMDBManager.shared.request(api: .thisYearTv(originCountry: .kr, year: Date().getYearToStr), resultType: TvListResDto.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { result in
                if let result = result as? MediaItemList {
                    self.thisYearTv = result.results
                }
//                self.thisYearTv = result.toDomain().results //result.results.map { $0.toDomain() }
            }
            .store(in: &cancellable)

    }
}
