//
//  SearchView.swift
//  WatchIt
//
//  Created by 김지연 on 4/24/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)
                .padding(.horizontal, 10)
            Spacer()
        }
    }
}

#Preview {
    SearchView()
}
