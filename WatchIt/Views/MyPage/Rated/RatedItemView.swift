//
//  RatedItemView.swift
//  WatchIt
//
//  Created by 김지연 on 5/14/24.
//

import SwiftUI
import ComposableArchitecture

struct RatedItemView: View {
    let store: StoreOf<RatedItemFeature>
    var type: MediaType = .movie
    var mediaItems: MediaItems = []
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 3)
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, content: {
                    ForEach(store.itemList, id: \.self) { item in
                        
                        
                        NavigationLink(value: item) {
                            MediaItemVerticalView(item: item, starRate: item.starRate)
                                .foregroundStyle(.black)
                        }
                    }
                    
                })
                .padding(.leading, 20)
            }
            .navigationDestination(for: MediaItem.self) { item in
                WithPerceptionTracking {
                    MediaDetailView(id: item.id, title: item.title, type: type)
                }
                
            }
            .navigationTitle("\(type.rawValue)")
            .customNavBackButton()
            .onAppear() {
                store.send(.requestRatedItems(type: type, ascending: false))
//                mediaItems = store.itemList
            }
        }
        
    }
}

#Preview {
    RatedItemView(store: Store(initialState: RatedItemFeature.State()) {
        RatedItemFeature() }, type: .movie, mediaItems: [])
}
