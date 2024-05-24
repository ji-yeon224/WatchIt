//
//  WishItemView.swift
//  WatchIt
//
//  Created by 김지연 on 5/23/24.
//

import SwiftUI
import ComposableArchitecture

struct WishItemGridView: View {
    var type: MediaType = .movie
    let store: StoreOf<WishItemFeature>
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10, alignment: .top), count: 3)
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading)  {
                    ForEach(store.itemList, id: \.self) { item in
                        NavigationLink(value: item) {
                            MediaItemVerticalView(item: item)
                                .foregroundStyle(.black)
                        }
                    }
                }
                .padding(.leading, 20)
            }
            .navigationDestination(for: MediaItem.self) { item in
                WithPerceptionTracking {
                    MediaDetailView(id: item.id, title: item.title, type: type)
                }
                
            }
            .navigationTitle("\(type.title)")
            .navigationBarTitleDisplayMode(.inline)
            .customNavBackButton()
            .onAppear() {
                store.send(.requestWishItem(type: type))
            }
        }
            
    }
}

#Preview {
    
    WishItemGridView(store: Store(initialState: WishItemFeature.State(), reducer: {
        WishItemFeature()
    }))
}
