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
            
            NavigationLink(value: item) {
                SearchItemView(media: item)
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: MediaItem.self) { item in
//            MediaDetailView(movieId: item.id, title: item.title)
            MediaDetailView(MediaDetailViewModel(), id: item.id, title: item.title, type: .movie)
        }
    }
}

#Preview {
    SearchItemListView()
}
