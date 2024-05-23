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
        var averageRate: Double = 0.0
    }
    
    enum Action {
        case requestRateData
        case setRateData([ChartData])
        case setAvarageRate(Double)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .requestRateData:
                return requestRateData()
            case let .setRateData(data):
                state.chartData = data
                return .none
            case let .setAvarageRate(avg):
                state.averageRate = avg
                return .none
            }
        }
    }
}

extension MyPageFeature {
    private func requestRateData() -> Effect<Action> {
        var data: [ChartData] = []
        var average: Double
        var sum: Double = 0
        let totalCount = Double(repository.fetchAll().count)
        for rate in stride(from: 0.5, to: 5.0, by: 0.5) {
            let count = Double(repository.getRateCount(rate: rate))
            data.append(.init(rate: rate, count: count/totalCount))
            
            sum += (count * rate)
        }
        
        average = sum / totalCount
        
        return .merge([
            .send(.setRateData(data)),
            .send(.setAvarageRate(average))
        ])
    }
}

struct ChartData: Equatable {
    let id = UUID()
    var rate: Double
    var count: Double
}
