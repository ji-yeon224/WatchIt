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
                
                starScore
                
                if let detail = viewModel.details, !detail.overView.isEmpty {
                    OverviewView(overViewText: detail.overView)
                    Divider()

                }
                if viewModel.castItems.count > 0 {
                    CreditView(creditItems: CreditItems(title: "출연진", items: viewModel.castItems))
                    Divider()
                }
                
                if viewModel.crewItems.count > 0 {
                    CreditView(creditItems: CreditItems(title: "제작", items: viewModel.crewItems))
                }
                
            }
            .padding(10)
            
        }
        .onAppear {
            
            viewModel.action(.setMediaType(type))
            viewModel.action(.getDetailInfo(type, id))
            viewModel.action(.getCreditInfo(type, id))
            
            viewModel.bind()
             
        }
        .navigationTitle(title)
        .customNavBackButton()
        
    }
    
    
    private var starScore: some View {
        VStack(alignment: .leading, spacing: 15) {
            if viewModel.starValue == 0.0 {
                Text("나의 별점 \(0)")
                    .font(Constants.FontStyle.boldPlain.style)
            } else {
                
                Text("나의 별점 \(String(format: "%.1f", viewModel.starValue))")
                    .font(Constants.FontStyle.boldPlain.style)
            }
            StarRatingView(value: $viewModel.starValue)
            Divider()
        }
        
    }
    
    
        
}

#Preview {
//    MovieDetailView(movieId: 693134, title: "듄: 파트2")
    MediaDetailView(MediaDetailViewModel(), id: 208825, title: "듄: 파트2", type: .tv)
    
}
