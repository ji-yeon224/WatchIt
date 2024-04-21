//
//  ContentView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI

struct MovieView: View {
    @StateObject var viewModel = MovieListViewModel()
    @State private var tabIdx = 0
    var body: some View {
        NavigationStack {
            VStack {
                TopTabBarView(curTab: $tabIdx)
                if tabIdx == 0 {
                    MovieListView(viewModel)
                    .listStyle(.plain)
                }
            }
            .listStyle(.plain)
        }
        .task {
            viewModel.action(.getMovieTrend)
            viewModel.action(.getTopRated)
            viewModel.action(.nowPlaying)
            
        }
       
        
        
        
        
    }
}

#Preview {
    MovieView()
}
