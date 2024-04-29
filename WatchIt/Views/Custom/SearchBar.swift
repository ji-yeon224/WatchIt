//
//  SearchBar.swift
//  WatchIt
//
//  Created by 김지연 on 4/29/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 8)
            TextField("영화나 TV 시리즈를 검색하세요!", text: $searchText)
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
