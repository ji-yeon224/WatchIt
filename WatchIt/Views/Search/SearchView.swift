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
    
    
    @State private var searchAction = CurrentValueSubject<String, Never>("")
    @State private var curFilterType: MediaType = .movie
    @State private var filterHidden: Bool = true
    
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchBar(searchText: $viewModel.searchText, searchAction: $searchAction)
            filterButton
            if !viewModel.searchText.isEmpty {
                SearchItemListView(mediaList: viewModel.mediaList)
            }
            
            
            Spacer()
        }
        .padding(.horizontal, 10)
        .onReceive(searchAction, perform: { value in
            if !value.isEmpty {
                viewModel.action(.searchReqeust(type: curFilterType))
                filterHidden = false
                
            }
            
        })
        .overlay(alignment: .center) {
            progressView
        }
        
    }
    
    @ViewBuilder
    private var filterButton: some View {
        if !filterHidden && viewModel.mediaList.count > 0 {
            SearchFilterButtonList(curFilter: $curFilterType)
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
