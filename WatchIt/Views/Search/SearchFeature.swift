//
//  SearchFeature.swift
//  WatchIt
//
//  Created by 김지연 on 5/7/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SearchFeature {
    @ObservableState
    struct State: Equatable {
        var searchText: String = ""
        var searchFilter: MediaType = .movie
        var isLoading: Bool = false
        var searchResult: [MediaItem] = []
        var error: String?
    }
    
    enum Action: Equatable {
        case searchAction(String)
        case setSearchText(String)
        case setFilter(MediaType)
        case resetResult
        case responseResult([MediaItem])
        case errorDescriptions(String)
        case showProgressView(Bool)
        
    }
    var body: some Reducer<State, Action> {

        Reduce { state, action in
            switch action {
            case let .searchAction(text):
                state.isLoading = true
                if state.searchFilter == .movie {
                    return .concatenate([
                        searchRequest(query: text, type: state.searchFilter, resultType: MovieListResDto.self),
                        .send(.showProgressView(false))
                    ])
                } else {
                    return .concatenate([
                        searchRequest(query: state.searchText, type: state.searchFilter, resultType: TvListResDto.self),
                        .send(.showProgressView(false))
                    ])
                }
            case let .setSearchText(text):
                state.searchText = text
                if text.isEmpty {
                    return .send(.resetResult)
                }
                return .none
            case let .setFilter(type):
                if !state.searchText.isEmpty, state.searchFilter != type {
                    state.searchFilter = type
                    return .send(.searchAction(state.searchText))
                }
                
                return .none
            case .resetResult:
                state.searchResult = []
                return .none
            case let .responseResult(data):
                state.searchResult = data
                return .none
            case let .errorDescriptions(error):
                state.error = error
//                print(error)
                return .none
            case let .showProgressView(isLoading):
                state.isLoading = isLoading
                return .none
            }
            
        }
    }
    
    
}

extension SearchFeature {
    
    private func searchRequest<T: ResponseProtocol>(query: String, type: MediaType, resultType: T.Type) -> Effect<Action> {
        return .run { send in
            let response = try await TMDBManager.shared.request(api: .search(type: type, region: .kr, query: query), resultType: resultType)
            if let response = response as? MediaItemList {
                await send(.responseResult(response.results))
            }
        }
    }
    
}
