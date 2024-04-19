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
    var title: String = ""
    
    var body: some View {
        ScrollView {
            MovieInfoView(details: viewModel.movieDetail)
                .padding(.bottom, 20)
            Divider()
            LazyVStack(alignment: .leading, spacing: 20) {
                OverviewView(overViewText: viewModel.movieDetail?.overView)
                Divider()

                CreditView(creditItems: CreditItems(title: "출연진", items: viewModel.castItems))
                Divider()
                CreditView(creditItems: CreditItems(title: "제작", items: viewModel.crewItems))
            }
            .padding(10)
            
            
        }
        .onAppear {
            if let movieId = movieId {
                viewModel.getDetails(movieId: movieId)
                viewModel.getCredits1(type: .movie, id: movieId)
            }
            
             
        }
        .navigationTitle(title)
    }
        
}

#Preview {
    MovieDetailView(movieId: 693134, title: "듄: 파트2")
}
