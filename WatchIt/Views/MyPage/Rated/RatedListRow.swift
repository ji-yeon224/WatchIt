//
//  RatedListRow.swift
//  WatchIt
//
//  Created by 김지연 on 5/13/24.
//

import SwiftUI
import ComposableArchitecture
struct RatedListRow: View {
    var title: MediaType = .movie
    
    var body: some View {
        NavigationLink(value: MyPageDestination.rate(title)) {
            HStack {
                Text(title.title)
                    .font(Constants.FontStyle.subtitle.style)
                Spacer()
                Image(.rightArrow)
                
                
            }
        }
        .foregroundStyle(.black)
        .frame(height: 40)
        
//        .navigationDestination(for: MediaType.self) { type in
//            RatedItemView(store: Store(initialState: RatedItemFeature.State()) {
//                RatedItemFeature() }, type: type )
//        }
        
    }
}

#Preview {
    RatedListRow()
}
