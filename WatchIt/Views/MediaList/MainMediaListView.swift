//
//  ContentView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI
import ComposableArchitecture

struct MainMediaListView: View {
    @Environment(\.scenePhase) var scenePhase
    
    @Perception.Bindable var store = Store(initialState: MainMediaListFeature.State()) {
        MainMediaListFeature()
    }
    
//    @StateObject private var tvViewModel = TvListViewModel()
    
    let tabStore: StoreOf<ContentFeature>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack {
                VStack {
                    TopTabBarView(curTab: $store.tabIdx.sending(\.setTabIdx))
                    if store.state.tabIdx == 0 {
                        MovieListView(
                            store: tabStore.scope(state: \.movieListTab, action: \.movieListTab),
                            viewLoaded: $store.movieListLoaded.sending(\.setMovieListLoaded))
                        
                    } else if store.state.tabIdx == 1 {
                        TvListView(
                            store: tabStore.scope(state: \.tvListTab, action: \.tvListTab),
                           viewLoaded: $store.tvListLoaded.sending(\.setTvListLoaded))
                        
                    }
                }
                .listStyle(.plain)
            }
        }
        
        
        
    }
}

#Preview {
    MainMediaListView(tabStore: Store(initialState: ContentFeature.State(), reducer: {
        ContentFeature()
    }))
}
