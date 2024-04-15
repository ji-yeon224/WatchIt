//
//  MovieListView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI

struct MovieRowView: View {
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top) {
                ForEach(viewModel.movieData) { movie in
                    MovieView(movie: movie)
                }
            }
            
        }
        .padding()
        .onAppear {
            viewModel.getTrendList()
        }
        
    }
        
}

//#Preview {
//    let movielist: [Movie] = [Movie(id: 1, title: "111111111111111"), Movie(id: 2, title: "22"), Movie(id: 3, title: "33")]
//    return MovieRowView(movieList: movielist)
//}
