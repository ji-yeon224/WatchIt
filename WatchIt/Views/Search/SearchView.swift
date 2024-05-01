//
//  SearchView.swift
//  WatchIt
//
//  Created by 김지연 on 4/24/24.
//

import SwiftUI
import Combine

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchBar(searchText: $viewModel.searchText, searchAction: $viewModel.searchAction)
            filterButton
            if !viewModel.searchText.isEmpty {
                SearchItemListView(mediaList: viewModel.mediaList)
            }
            
            
            Spacer()
        }
        .padding(.horizontal, 10)
        .overlay(alignment: .center) {
            progressView
        }
        .onAppear() {
            viewModel.bind()
        }
        
    }
    
    
    
}

extension SearchView {
    
    @ViewBuilder
    private var filterButton: some View {
        if viewModel.mediaList.count > 0 {
            SearchFilterButtonList(curFilter: $viewModel.curFilterType)
                .padding(.horizontal, 5)
        }
        
    }
    
    @ViewBuilder
    private var progressView: some View {
        if viewModel.isLoading {
            ProgressView()
                .frame(width: .infinity, alignment: .center)
        }
    }
}

#Preview {
    SearchView()
}
