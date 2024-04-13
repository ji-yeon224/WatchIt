//
//  MovieView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI
import Combine

struct MovieView: View {
    var movie: Movie
    @ObservedObject var viewModel = MovieViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            movie.image
                .resizable()
                .frame(width: 100, height: 150)
            Text(movie.title)
                .frame(width: 100)
                
        }
        .onAppear {
            viewModel.getTrendList()

        }
    }
        
}

#Preview {
    MovieView(movie: Movie(id: 1, title: "movie"))
}
