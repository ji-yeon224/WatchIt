//
//  MovieListView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI

struct MovieTrendRowView: View {
    @StateObject private var viewModel: MovieTrendViewModel
    
    init(_ viewModel: MovieTrendViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        switch viewModel.state {
        case let .trendData(movieData):
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top) {
                    ForEach(movieData) { movie in
                        NavigationLink(value: movie) {
                            MovieItemView(movie: movie)
                        }
                        .buttonStyle(.plain)
                        
                    }
                }
                
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .navigationDestination(for: MovieTrend.self) { item in
                MovieDetailView(movieId: item.id, title: item.title)
            }
            
        }
        
        
        
        
        
        
        
        
        
    }
    
}

//#Preview {
//    return MovieTrendRowView()
//}
