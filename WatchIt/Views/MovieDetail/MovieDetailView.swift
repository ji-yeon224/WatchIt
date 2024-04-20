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
        switch viewModel.state {
        case .detailInfo(let movie):
            ScrollView {
                
                MovieInfoView(details: movie)
                    .padding(.bottom, 20)
                Divider()
                LazyVStack(alignment: .leading, spacing: 20) {
                    OverviewView(overViewText: movie?.overView)
                    Divider()

                    CreditView(creditItems: CreditItems(title: "출연진", items: viewModel.castItems))
                    Divider()
                    CreditView(creditItems: CreditItems(title: "제작", items: viewModel.crewItems))
                }
                .padding(10)
                
            }
            .onAppear {
                if let movieId = movieId {
                    viewModel.action(.getDetailInfo(movieId))
                    viewModel.action(.getCreditInfo(.movie, movieId))
                }
                
                 
            }
            .navigationTitle(title)
            .customNavBackButton()
            
        }
        
        
    }
    
    
        
}

#Preview {
    MovieDetailView(movieId: 693134, title: "듄: 파트2")
}
