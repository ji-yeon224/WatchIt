//
//  SaveListView.swift
//  WatchIt
//
//  Created by 김지연 on 5/23/24.
//

import SwiftUI

struct WishListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Wish List")
                .font(Constants.FontStyle.title1.style)
            HStack(spacing: 20) {
                WishTypeButton(image: .savedMovieButton, title: "영화")
                WishTypeButton(image: .savedTvButton, title: "TV")
                Spacer()
            }
        }
        .padding(.vertical, 14)
        
    }
    
    
}

#Preview {
    WishListView()
}
