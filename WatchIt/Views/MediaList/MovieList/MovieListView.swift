//
//  MovieListView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI
import ComposableArchitecture

struct MovieListView: View {
//    @StateObject private var viewModel: MovieListViewModel
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
    //            MediaDetailView(movieId: item.id, title: item.title)
                MediaDetailView(MediaDetailViewModel(), id: item.id, title: item.title, type: .movie)
            }
            .task {
                if !viewLoaded {
                    viewLoaded = true
                    store.send(.viewDidLoad)
    //                viewModel.action(.getMovieTrend)
    //                viewModel.action(.getTopRated)
    //                viewModel.action(.nowPlaying)
                }
                
            }
        }
        
    }
    
}
//    
//#Preview {
//    return MovieListView(MovieListViewModel(), viewLoaded: .constant(false))
//}
