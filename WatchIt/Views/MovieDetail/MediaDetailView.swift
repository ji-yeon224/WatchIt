//
//  MovieDetailView.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import SwiftUI
import ComposableArchitecture

struct MediaDetailView: View {
    
    @Perception.Bindable var store: StoreOf<MediaDetailFeature> = WatchItApp.store.scope(state: \.detail, action: \.detail)
    
    @State private var isSavedItem: Bool = false
    private var id: Int
    private var title: String
    private var type: MediaType
    
    init(id: Int, title: String, type: MediaType) {
        
        self.id = id
        self.title = title
        self.type = type
    }
    
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                
                MovieInfoView(details: store.state.details, isSaved: $store.wishSaved.sending(\.setWishSaved))
                    .padding(.bottom, 20)
                Divider()
                
                LazyVStack(alignment: .leading, spacing: 20) {
                    
                    starScore
                    
                    if let detail = store.state.details, !detail.overView.isEmpty {
                        OverviewView(overViewText: detail.overView)
                        Divider()

                    }
                    if store.state.castItems.count > 0 {
                        CreditView(creditItems: CreditItems(title: "출연진", items: store.state.castItems))
                        Divider()
                    }
                    
                    if store.state.crewItems.count > 0 {
                        CreditView(creditItems: CreditItems(title: "제작", items: store.state.crewItems))
                    }
                    
                }
                .padding(10)
                
            }
            .onAppear {
                store.send(.onAppear(type: type, id: id))
                 
            }
            .navigationTitle(title)
            .customNavBackButton()
        }
        
        
    }
    
    
    private var starScore: some View {
        VStack(alignment: .leading, spacing: 15) {
            if store.state.starValue == 0.0 {
                Text("나의 별점 \(0)")
                    .font(Constants.FontStyle.boldPlain.style)
            } else {
                
                Text("나의 별점 \(String(format: "%.1f", store.state.starValue))")
                    .font(Constants.FontStyle.boldPlain.style)
            }
            StarRatingView(value: $store.starValue.sending(\.setStarValue))
            Divider()
        }
        
    }
    
    
        
}

#Preview {
//    MovieDetailView(movieId: 693134, title: "듄: 파트2")
    MediaDetailView(id: 208825, title: "듄: 파트2", type: .tv)
    
}
