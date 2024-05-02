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
            getMediaItems(for: .trend(type: .tv)) { [weak self] result in
                self?.tvTrendData = result
            }
        case .tvTopRated:
            getMediaItems(for: .topRated(type: .tv, region: .kr)) { [weak self] result in
                self?.tvTopRated = result
            }
        case .thisYear:
            getMediaItems(for: .thisYearTv(originCountry: .kr, year: Date().getYearToStr)) { [weak self] result in
                self?.thisYearTv = result
            }
        }
    }
    
    
    private func getMediaItems(for api: Router, completion: @escaping ([MediaItem]) -> Void) {
        TMDBManager.shared.request(api: api, resultType: TvListResDto.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { result in
                if let result = result as? MediaItemList {
                    completion(result.results)
                }
            }
            .store(in: &cancellable)
        
    }
    
}
