//
//  RatedItemView.swift
//  WatchIt
//
//  Created by 김지연 on 5/14/24.
//

import SwiftUI
import ComposableArchitecture


struct RatedItemGridView: View {
    @Perception.Bindable var store: StoreOf<RatedItemFeature>
    var type: MediaType = .movie
    var mediaItems: MediaItems = []
    
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10, alignment: .topLeading), count: 3)
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading, content: {
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
            .navigationTitle("\(type.title)")
            .navigationBarTitleDisplayMode(.inline)
            .customNavBackButton()
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    filterMenuView
                }
            })
            .onAppear() {
                store.send(.requestRatedItems(type: type, ascending: false))
            }
        }
        
    }
    
    private var filterMenuView: some View {
        Menu {
            Picker("filter", selection: $store.filterState.sending(\.setItemFilter)) {
                ForEach(FilterState.allCases, id: \.self) { filter in
                    Text(filter.pickerTitle).tag(filter)
                }
            }

        } label: {
            Image(.filter)
        }

    }
}

#Preview {
    RatedItemGridView(store: Store(initialState: RatedItemFeature.State()) {
        RatedItemFeature() }, type: .movie, mediaItems: [])
}
