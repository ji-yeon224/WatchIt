//
//  MyPageFeature.swift
//  WatchIt
//
//  Created by 김지연 on 5/9/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MyPageFeature {
    
    private let repository = StarRatedRepository()
    @ObservableState
    struct State: Equatable {
        var chartData: [ChartData] = []
    }
    
    enum Action {
        case requestRateData
        case setRateData([ChartData])
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .requestRateData:
                return requestRateData()
            case let .setRateData(data):
                state.chartData = data
                return .none
            }
        }
    }
}

extension MyPageFeature {
    private func requestRateData() -> Effect<Action> {
        var data: [ChartData] = []
        for rate in stride(from: 0.5, to: 5.0, by: 0.5) {
            let count = repository.getRateCount(rate: rate)
            data.append(.init(rate: rate, count: count))
            
        }
        return .send(.setRateData(data))
    }
}

struct ChartData: Equatable {
    let id = UUID()
    var rate: Double
    var count: Int
}
