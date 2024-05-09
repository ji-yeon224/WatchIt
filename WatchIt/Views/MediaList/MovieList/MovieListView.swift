//
//  MovieListView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI
import ComposableArchitecture

struct MovieListView: View {
    
    let store: StoreOf<MovieListFeature>
    
    @Binding var viewLoaded: Bool
    
    init(store: StoreOf<MovieListFeature>, viewLoaded: Binding<Bool>) {
        self.store = store
        self._viewLoaded = Binding(projectedValue: viewLoaded)
    }
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView(.vertical) {

                MediaListRowView(title: "TREND", itemList: store.state.trendData)
                MediaListRowView(title: "Now Playing", itemList: store.state.nowPlayingData)
                MediaListRowView(title: "TOP RATED", itemList: store.state.topRatedData)
                
            }
            .navigationDestination(for: MediaItem.self) { item in
                WithPerceptionTracking {
                    MediaDetailView(id: item.id, title: item.title, type: .movie)
                }
                
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
//    
//#Preview {
//    return MovieListView(MovieListViewModel(), viewLoaded: .constant(false))
//}
