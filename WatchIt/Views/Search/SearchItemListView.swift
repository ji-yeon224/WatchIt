//
//  SwiftUIView.swift
//  WatchIt
//
//  Created by 김지연 on 5/1/24.
//

import SwiftUI

struct SearchItemListView: View {
    var mediaList: [MediaItem] = []
    var body: some View {
        List(mediaList) { item in
            SearchItemView(media: item)
        }
        .listStyle(.plain)
    }
}

#Preview {
    SearchItemListView()
}
