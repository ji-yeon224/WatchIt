//
//  TvListView.swift
//  WatchIt
//
//  Created by 김지연 on 4/21/24.
//

import SwiftUI
import ComposableArchitecture

struct TvListView: View {
    let store: StoreOf<TvListFeature>
    
    @Binding var viewLoaded: Bool
    init(store: StoreOf<TvListFeature>, viewLoaded: Binding<Bool>) {
        self.store = store
        self._viewLoaded = Binding(projectedValue: viewLoaded)
    }
    var body: some View {
        WithPerceptionTracking {
            ScrollView(.vertical) {
                MediaListRowView(title: "Korea Series", itemList: store.state.thisYear)
                MediaListRowView(title: "Trend", itemList: store.state.trendData)
                MediaListRowView(title: "Top Rated", itemList: store.state.topRated)
                
            }
            .navigationDestination(for: MediaItem.self) { item in
                MediaDetailView(id: item.id, title: item.title, type: .tv)
            }
            .task {
                if !viewLoaded {
                    viewLoaded = true
                    store.send(.viewDidLoad)
                }
            }
        }
        
    }
}

//#Preview {
//    TvListView(TvListViewModel(), viewLoaded: .constant(false))
//}
