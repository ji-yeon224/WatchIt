//
//  ContentView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI

struct MainMediaListView: View {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var viewModel = MovieListViewModel()
    @State private var tabIdx = 0
    @State private var movieListViewLoaded = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TopTabBarView(curTab: $tabIdx)
                if tabIdx == 0 {
                    MovieListView(viewModel, viewLoaded: $movieListViewLoaded)
                    
                } else if tabIdx == 1 {
                    TvListView()
                    
                }
            }
            .listStyle(.plain)
        }
        
        
    }
}

#Preview {
    MainMediaListView()
}
