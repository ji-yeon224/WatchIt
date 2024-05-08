//
//  TvListFeature.swift
//  WatchIt
//
//  Created by 김지연 on 5/8/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct TvListFeature {
    @ObservableState
    struct State {
        var trendData: [MediaItem] = []
        var topRated: [MediaItem] = []
        var thisYear: [MediaItem] = []
    }
    
    enum Action {
        case viewDidLoad
        case request(Category)
        case response([MediaItem], Category)
    }
    
    enum Category {
        case tvTrend
        case topRated
        case thisYear
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewDidLoad:
                return .merge([
                    .send(.request(.tvTrend)),
                    .send(.request(.topRated)),
                    .send(.request(.thisYear))
                ])
            case let .request(category):
                return getMediaItems(category: category)
            case let .response(data, category):
                switch category {
                case .topRated:
                    state.topRated = data
                    return .none
                case .tvTrend:
                    state.trendData = data
                    return .none
                case .thisYear:
                    state.thisYear = data
                    return .none
                }
            }
        }
    }
}

extension TvListFeature {
    private func getMediaItems(category: Category) -> Effect<Action> {
        var api: Router
        switch category {
        case .tvTrend:
            api = .trend(type: .tv)
        case .topRated:
            api = .topRated(type: .tv, region: .kr)
        case .thisYear:
            api = .thisYearTv(originCountry: .kr, year: Date().getYearToStr)
        }
        return .run { [api = api] send in
            let response = try await TMDBManager.shared.request(api: api, resultType: TvListResDto.self)
            if let response = response as? MediaItemList {
                await send(.response(response.results, category))
            }
        }
    }
}
