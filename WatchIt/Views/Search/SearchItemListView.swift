//
//  SwiftUIView.swift
//  WatchIt
//
//  Created by 김지연 on 5/1/24.
//

import SwiftUI

struct SearchItemListView: View {
    private var mediaList: [MediaItem] = []
    private var mediaType: MediaType = .movie
    init(mediaList: [MediaItem], curtype: MediaType) {
        self.mediaList = mediaList
        self.mediaType = curtype
    }
    var body: some View {
        List(mediaList) { item in
            
            NavigationLink(value: item) {
                SearchItemView(media: item)
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: MediaItem.self) { item in
            MediaDetailView(MediaDetailViewModel(), id: item.id, title: item.title, type: mediaType)
        }
    }
}

#Preview {
    SearchItemListView(mediaList: [], curtype: .movie)
}
