//
//  ContentView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI

struct MovieView: View {
    @StateObject var viewModel = MovieTrendViewModel()
    @State private var tabIdx = 0
    var body: some View {
        NavigationStack {
            VStack {
                TopTabBarView(curTab: $tabIdx)
                if tabIdx == 0 {
                    MovieTrendRowView(viewModel)
                    .listStyle(.plain)
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            viewModel.action(.getMovieTrend)
        }
       
        
        
        
        
    }
}

#Preview {
    MovieView()
}
