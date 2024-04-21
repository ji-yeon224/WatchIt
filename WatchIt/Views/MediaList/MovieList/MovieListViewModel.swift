//
//  MovieViewModel.swift
//  WatchIt
//
//  Created by 김지연 on 4/13/24.
//

import Foundation
import Combine

final class MovieListViewModel: ViewModelProtocol {
    
    private var cancellable: Set<AnyCancellable> = []
    @Published var trendData: [MediaItem] = []
    @Published var topRatedData: [MediaItem] = []
    @Published var nowPlayingData: [MediaItem] = []
    
    enum Action {
        case getMovieTrend
        case getTopRated
        case nowPlaying
    }
    
    func action(_ action: Action) {
        switch action {
        case .getMovieTrend:
            getTrendList()
        case .getTopRated:
            getTopRatedList()
        case .nowPlaying:
            getNowPlayingList()
        }
    }
    
    private func getTrendList() {
        TMDBManager.shared.request(api: .trend(type: .movie), resultType: MovieListDto.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { result in
                let data = result.results
                self.trendData = data.map { $0.toDomain() }
            }
            .store(in: &cancellable)
    }
    
    private func getTopRatedList() {
        TMDBManager.shared.request(api: .topRated(type: .movie, region: .kr), resultType: MovieListDto.self)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { result in
                self.topRatedData = result.results.map { $0.toDomain() }
            }
            .store(in: &cancellable)


    }
    
    private func getNowPlayingList() {
        TMDBManager.shared.request(api: .nowPlaying(type: .movie, region: .kr), resultType: MovieListDto.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { result in
                self.nowPlayingData = result.results.map { $0.toDomain() }
            }
            .store(in: &cancellable)

    }
}