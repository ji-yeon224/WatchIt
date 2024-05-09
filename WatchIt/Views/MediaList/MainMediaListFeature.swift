//
//  MainMediaListFeature.swift
//  WatchIt
//
//  Created by 김지연 on 5/7/24.
//

import ComposableArchitecture

@Reducer
struct MainMediaListFeature {
    @ObservableState
    struct State {
        var tabIdx = 0
        var movieListLoaded = false
        var tvListLoaded = false
    }
    
    enum Action {
        case setTabIdx(Int)
        case setMovieListLoaded(Bool)
        case setTvListLoaded(Bool)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setTabIdx(idx):
                state.tabIdx = idx
                return .none
            case let .setMovieListLoaded(isLoaded):
                state.movieListLoaded = isLoaded
                return .none
            case let .setTvListLoaded(isLoaded):
                state.tvListLoaded = isLoaded
                return .none
            }
        }
    }
    
}
