//
//  RatedItemView.swift
//  WatchIt
//
//  Created by 김지연 on 5/14/24.
//

import SwiftUI
import ComposableArchitecture

enum FilterState: CaseIterable {
    case ascending
    case descending
    
    var pickerTitle: String {
        switch self {
        case .ascending:
            return "별점 높은 순"
        case .descending:
            return "별점 낮은 순"
        }
    }
}

struct RatedItemView: View {
    @Perception.Bindable var store: StoreOf<RatedItemFeature>
    var type: MediaType = .movie
    var mediaItems: MediaItems = []
    
    @State private var filterType = FilterState.allCases
    @State private var curFilter: FilterState = .ascending
    
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
            .navigationTitle("\(type.title)")
            .navigationBarTitleDisplayMode(.inline)
            .customNavBackButton()
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("filter", selection: $store.filterState.sending(\.setItemFilter)) {
                            ForEach(filterType, id: \.self) { filter in
                                Text(filter.pickerTitle).tag(filter)
                            }
                        }

                    } label: {
                        Image(.filter)
                    }

                }
            })
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
