//
//  MovieListView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel: MovieListViewModel
    
    init(_ viewModel: MovieListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.vertical) {

            MovieListRowView(title: "TREND", itemList: viewModel.trendData)
            MovieListRowView(title: "TOP RATED", itemList: viewModel.topRatedData)
            
        }
        .navigationDestination(for: MovieItem.self) { item in
            MovieDetailView(movieId: item.id, title: item.title)
        }
        
        
    }
    
}
    
#Preview {
    return MovieListView(MovieListViewModel())
}
