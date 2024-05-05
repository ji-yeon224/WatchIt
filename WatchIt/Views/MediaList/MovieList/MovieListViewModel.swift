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
            getMediaList(for: .trend(type: .movie)) { [weak self] result in
                self?.trendData = result
            }
        case .getTopRated:
            getMediaList(for: .topRated(type: .movie, region: .kr)) { [weak self] result in
                self?.topRatedData = result
            }
        case .nowPlaying:
            getMediaList(for: .nowPlaying(type: .movie, region: .kr)) { [weak self] result in
                self?.nowPlayingData = result
            }
        }
    }
    
    private func getMediaList(for api: Router, completion: @escaping ([MediaItem]) -> Void) {
        Task {
            do {
                let response = try await TMDBManager.shared.request(api: api, resultType: MovieListResDto.self)
                DispatchQueue.main.async {
                    if let response = response as? MediaItemList {
                        completion(response.results)
                    }
                }
            }
        }
    }
    
}
