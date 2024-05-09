//
//  MovieListFeature.swift
//  WatchIt
//
//  Created by 김지연 on 5/7/24.
//

import ComposableArchitecture

@Reducer
struct MovieListFeature {
    @ObservableState
    struct State: Equatable {
        var trendData: [MediaItem] = []
        var topRatedData: [MediaItem] = []
        var nowPlayingData: [MediaItem] = []
    }
    
    enum Action {
        case viewDidLoad
        case request(Category)
        case response([MediaItem], Category)
        
    }
    enum Category {
        case movieTrend
        case topRated
        case nowPlaying
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewDidLoad:
                return .merge([
                    .send(.request(.movieTrend)),
                    .send(.request(.topRated)),
                    .send(.request(.nowPlaying))
                ])
            case let .request(category):
                return getMediaList(for: category)
            case let .response(data, category):
                switch category {
                case .movieTrend:
                    state.trendData = data
                    return .none
                case .topRated:
                    state.topRatedData = data
                    return .none
                case .nowPlaying:
                    state.nowPlayingData = data
                    return .none
                }
            }
        }
    }
    private func getMediaList(for category: Category) -> Effect<Action> {
        
        var api: Router
        switch category {
        case .movieTrend:
            api = .trend(type: .movie)
        case .topRated:
            api = .topRated(type: .movie, region: .kr)
        case .nowPlaying:
            api = .nowPlaying(type: .movie, region: .kr)
        }
    
        return .run { [api = api] send in
            let response = try await TMDBManager.shared.request(api: api, resultType: MovieListResDto.self)
            if let response = response as? MediaItemList {
                await send(.response(response.results, category))
                
            }
        }
    }
}
