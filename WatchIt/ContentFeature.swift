//
//  ContentFeature.swift
//  WatchIt
//
//  Created by 김지연 on 5/7/24.
//

import ComposableArchitecture

@Reducer
struct ContentFeature {
    @ObservableState
    struct State {
        var searchTab = SearchFeature.State()
        var movieListTab = MovieListFeature.State()
    }
    enum Action {
        case searchTab(SearchFeature.Action)
        case movieListTab(MovieListFeature.Action)
    }
    var body: some ReducerOf<Self> {
        Scope(state: \.searchTab, action: \.searchTab) {
            SearchFeature()
        }
        Scope(state: \.movieListTab, action: \.movieListTab) {
            MovieListFeature()
        }
    }
}
