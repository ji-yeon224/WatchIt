//
//  SaveListView.swift
//  WatchIt
//
//  Created by 김지연 on 5/23/24.
//

import SwiftUI
import ComposableArchitecture

struct WishListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Wish List")
                .font(Constants.FontStyle.title1.style)
            HStack(spacing: 20) {
                WishListTypeItem(image: .savedMovieButton, title: .movie)
                WishListTypeItem(image: .savedTvButton, title: .tv)
                Spacer()
            }
        }
        .padding(.vertical, 14)
//        .navigationDestination(for: MyPageDestination.self) { dest in
//            WithPerceptionTracking {
//                WishItemView(type: type, store: WatchItApp.store.scope(state: \.wish, action: \.wish))
//            }
//            
//                
//        }
        
    }
    
    
}

#Preview {
    WishListView()
}
