//
//  MovieDetailView.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    @StateObject private var viewModel = MovieDetailViewModel()
    var movieId: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let details = viewModel.movieDetail {
                MovieInfoView(details: details)
                Spacer()
            }
            
        }
        .onAppear {
            if let movieId = movieId {
                viewModel.getDetails(movieId: movieId)
            }
            
        }
    }
        
}

#Preview {
    MovieDetailView(movieId: 693134)
}
