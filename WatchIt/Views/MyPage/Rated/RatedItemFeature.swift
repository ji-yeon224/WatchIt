//
//  RatedItemFeature.swift
//  WatchIt
//
//  Created by 김지연 on 5/14/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RatedItemFeature {
    
    private let repository = StarRatedRepository()
    
    @ObservableState
    struct State {
        var itemList: MediaItems = []
        
    }
    
    enum Action {
        case requestRatedItems(type: MediaType, ascending: Bool)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .requestRatedItems(type, ascending):
                state.itemList = repository.fetchItemByMediaType(type: type.rawValue, ascending: ascending)
                return .none
            }
        }
    }
}

