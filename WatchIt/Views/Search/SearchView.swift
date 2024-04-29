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
    @State private var searchAction: Bool = false
    @State private var searchAction1 = CurrentValueSubject<String, Never>("")
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText, searchAction: $searchAction1)
                .padding(.horizontal, 10)
            Spacer()
        }
        .onReceive(searchAction1, perform: { value in
            print(value)
        })
    }
}

#Preview {
    SearchView()
}
