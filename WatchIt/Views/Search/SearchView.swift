//
//  SearchView.swift
//  WatchIt
//
//  Created by 김지연 on 4/24/24.
//

import SwiftUI
import Combine
import ComposableArchitecture

struct SearchView: View {
//    @StateObject private var viewModel = SearchViewModel()
    @Perception.Bindable var store: StoreOf<SearchFeature>
    @State private var searchAction = CurrentValueSubject<String, Never>("")
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                SearchBar(searchText: $store.searchText.sending(\.setSearchText), searchAction: $searchAction)
                    .onReceive(searchAction) { value in
                        store.send(.searchAction(value))
                    }
                filterButton
                if !store.searchText.isEmpty {
                    SearchItemListView(mediaList: store.state.searchResult, curtype: store.state.searchFilter )
                }
                
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .overlay(alignment: .center) {
                progressView
            }
        }
        
    }
    
    
    
}

extension SearchView {
    
    @ViewBuilder
    private var filterButton: some View {
        if store.state.searchResult.count > 0 {
            SearchFilterButtonList(curFilter: $store.searchFilter.sending(\.setFilter))
                .padding(.horizontal, 5)
        }
        
        
    }
    
    @ViewBuilder
    private var progressView: some View {
        if store.state.isLoading {
            ProgressView()
                .frame(alignment: .center)
        }
    }
}

#Preview {
    SearchView(store: Store(initialState: SearchFeature.State(isLoading: false, searchResult: [], error: ""), reducer: {
        SearchFeature()
    }))
}
