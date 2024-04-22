//
//  MovieListView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel: MovieListViewModel
    @Binding var viewLoaded: Bool
    
    init(_ viewModel: MovieListViewModel, viewLoaded: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._viewLoaded = Binding(projectedValue: viewLoaded)
    }
    
    var body: some View {
        ScrollView(.vertical) {

            MediaListRowView(title: "TREND", itemList: viewModel.trendData)
            MediaListRowView(title: "Now Playing", itemList: viewModel.nowPlayingData)
            MediaListRowView(title: "TOP RATED", itemList: viewModel.topRatedData)
            
        }
        .navigationDestination(for: MediaItem.self) { item in
//            MediaDetailView(movieId: item.id, title: item.title)
            MediaDetailView(MediaDetailViewModel(), id: item.id, title: item.title, type: .movie)
        }
        .task {
            if !viewLoaded {
                viewLoaded = true
                viewModel.action(.getMovieTrend)
                viewModel.action(.getTopRated)
                viewModel.action(.nowPlaying)
            }
            
        }
    }
    
}
    
#Preview {
    return MovieListView(MovieListViewModel(), viewLoaded: .constant(false))
}
