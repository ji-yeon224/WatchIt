//
//  RatedListView.swift
//  WatchIt
//
//  Created by 김지연 on 5/14/24.
//

import SwiftUI
import ComposableArchitecture

struct RatedListView: View {
    var store: StoreOf<MyPageFeature>
    var body: some View {
        
        Text("평가 목록")
            .font(Constants.FontStyle.title1.style)
        VStack {
            RatedListRow(title: .movie)
            RatedListRow(title: .tv)
            
        }
        
    }
}

#Preview {
    RatedListView(store: Store(initialState: MyPageFeature.State()) {
        MyPageFeature()
    })
}
