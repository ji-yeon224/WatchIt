//
//  SearchView.swift
//  WatchIt
//
//  Created by 김지연 on 4/24/24.
//

import SwiftUI
import Combine

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var searchAction = CurrentValueSubject<String, Never>("")
    @State private var curFilterType: MediaType = .movie
    @State private var filterHidden: Bool = true
    var body: some View {
        VStack(alignment: .leading) {
            SearchBar(searchText: $searchText, searchAction: $searchAction)
            filterButton
                
            Spacer()
        }
        .padding(.horizontal, 10)
        .onReceive(searchAction, perform: { value in
            if !value.isEmpty {
                filterHidden = false
            }
            
        })
    }
    
    @ViewBuilder
    private var filterButton: some View {
        if !filterHidden && searchText.count > 0 {
            SearchFilterButtonList(curFilter: $curFilterType)
                .padding(.horizontal, 5)
        }
        
    }
}

#Preview {
    SearchView()
}
