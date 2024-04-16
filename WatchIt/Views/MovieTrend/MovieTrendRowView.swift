//
//  MovieListView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI

struct MovieTrendRowView: View {
    @StateObject var viewModel = MovieTrendViewModel()
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top) {
                ForEach(viewModel.movieData) { movie in
                    NavigationLink(value: movie) {
                        MovieItemView(movie: movie)
                    }
                    .buttonStyle(.plain)
                    
                }
            }
            
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .navigationDestination(for: MovieTrend.self) { item in
            MovieDetailView()
        }
        
        
        
        
        
        
        .onAppear {
            viewModel.getTrendList()
        }
        
    }
    
}

#Preview {
    return MovieTrendRowView()
}
