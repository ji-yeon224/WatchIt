//
//  SearchBar.swift
//  WatchIt
//
//  Created by 김지연 on 4/29/24.
//

import SwiftUI
import Combine

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var searchAction: CurrentValueSubject<String, Never>
//    @State private var textLen: Int
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 8)
            TextField("영화 또는 TV 시리즈를 검색해보세요!", text: $searchText)
                .onSubmit {
                    if !searchText.isEmpty {
                        searchAction.send(searchText.trimmingCharacters(in: .whitespaces))
                    }
                    
                }
                .autocorrectionDisabled(true)
                .tint(.black)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                            UIApplication.shared.endEditing()
                        }
                    , alignment: .trailing
                )
        }
        .font(Constants.FontStyle.plain.style)
        .frame(height: 44)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(.secondaryBg)
                .shadow(color: .gray.opacity(0.3), radius: 1)
        )
        
    }
}

//#Preview {
//    SearchBar()
//}
