//
//  TvListView.swift
//  WatchIt
//
//  Created by 김지연 on 4/21/24.
//

import SwiftUI

struct TvListView: View {
    @StateObject private var viewModel: TvListViewModel
    @Binding var viewLoaded: Bool
    init(_ viewModel: TvListViewModel, viewLoaded: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._viewLoaded = Binding(projectedValue: viewLoaded)
    }
    var body: some View {
        
        ScrollView(.vertical) {
            MediaListRowView(title: "Korea Series", itemList: viewModel.thisYearTv)
            MediaListRowView(title: "Trend", itemList: viewModel.tvTrendData)
            MediaListRowView(title: "Top Rated", itemList: viewModel.tvTopRated)
            
        }
        .navigationDestination(for: MediaItem.self) { item in
            MediaDetailView(MediaDetailViewModel(), id: item.id, title: item.title, type: .tv)
        }
        .task {
            if !viewLoaded {
                viewLoaded = true
                viewModel.action(.tvTrend)
                viewModel.action(.tvTopRated)
                viewModel.action(.thisYear)
            }
        }
    }
}

#Preview {
    TvListView(TvListViewModel(), viewLoaded: .constant(false))
}
