//
//  MovieDetailView.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import SwiftUI

struct MediaDetailView: View {
    
    @StateObject private var viewModel: MediaDetailViewModel
    
    private var id: Int
    private var title: String
    private var type: MediaType
    
    init(_ viewModel: MediaDetailViewModel, id: Int, title: String, type: MediaType) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.id = id
        self.title = title
        self.type = type
    }
    
    
    var body: some View {
        ScrollView {
            
            MovieInfoView(details: viewModel.details)
                .padding(.bottom, 20)
            Divider()
            LazyVStack(alignment: .leading, spacing: 20) {
                if let detail = viewModel.details, !detail.overView.isEmpty {
                    OverviewView(overViewText: detail.overView)
                    Divider()

                }
               
                CreditView(creditItems: CreditItems(title: "출연진", items: viewModel.castItems))
                Divider()
                CreditView(creditItems: CreditItems(title: "제작", items: viewModel.crewItems))
            }
            .padding(10)
            
        }
        .onAppear {
            viewModel.action(.getDetailInfo(type, id))
            viewModel.action(.getCreditInfo(type, id))
            
             
        }
        .navigationTitle(title)
        .customNavBackButton()
        
    }
    
    
        
}

#Preview {
//    MovieDetailView(movieId: 693134, title: "듄: 파트2")
    MediaDetailView(MediaDetailViewModel(), id: 208825, title: "듄: 파트2", type: .tv)
    
}
