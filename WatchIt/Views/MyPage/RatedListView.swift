//
//  RatedListView.swift
//  WatchIt
//
//  Created by 김지연 on 5/14/24.
//

import SwiftUI

struct RatedListView: View {
    var body: some View {
        Text("평가 리스트")
            .font(Constants.FontStyle.title1.style)
        VStack {
            RatedListRow(title: .movie)
            RatedListRow(title: .tv)
            
        }
        .navigationDestination(for: MediaType.self) { type in
            RatedItemView()
        }
    }
}

#Preview {
    RatedListView()
}
