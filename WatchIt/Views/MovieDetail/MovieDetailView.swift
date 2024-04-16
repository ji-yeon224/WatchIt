//
//  MovieDetailView.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    @StateObject private var viewModel = MovieDetailViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let details = viewModel.movieDetail {
                MovieInfoView(details: details)
                Spacer()
            }
            
        }
        .onAppear {
            viewModel.getDetails(movieId: 693134)
        }
    }
        
}

#Preview {
    MovieDetailView()
}
