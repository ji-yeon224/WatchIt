//
//  WishItemFeature.swift
//  WatchIt
//
//  Created by 김지연 on 5/24/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WishItemFeature {
    private let repository = WishItemRepository()
    
    @ObservableState
    struct State {
        var itemList: MediaItems = []
        
    }
    enum Action {
        case requestWishItem(type: MediaType)
        
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .requestWishItem(type):
                state.itemList = repository.fetchItemByMediaType(type: type.rawValue)
                return .none
                
            }
        }
    }
}
