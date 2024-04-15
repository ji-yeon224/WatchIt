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
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top) {
                    ForEach(viewModel.movieData) { movie in
                        MovieItemView(movie: movie)
                    }
                }
                
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
        
        
        .onAppear {
            viewModel.getTrendList()
        }
        
    }
        
}

#Preview {
    return MovieTrendRowView()
}
