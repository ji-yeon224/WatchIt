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
        ScrollView {
            MovieInfoView(details: viewModel.movieDetail)
                .padding(.bottom, 20)
            Divider()
            LazyVStack(alignment: .leading, spacing: 20) {
                OverviewView(overViewText: viewModel.movieDetail?.overView)
                Divider()
                CreditItemsRow(id: movieId)
            }
            .padding(10)
            
            
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
