//
//  MovieView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI
import Combine
import Kingfisher

struct MediaItemView: View {
    var item: MediaItem
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            if let url = movie.posterUrl {
                PosterImage(url: url)

            } else {
                
                Rectangle()
                    .frame(width: 100, height: 150)
                    .foregroundStyle(.gray)
            }
            Text(item.title)
                .font(Constants.FontStyle.plain.style)
                .lineLimit(2)
                .frame(maxWidth: 100, alignment: .topLeading)
                
                
        }
    }
        
}

#Preview {
    MediaItemView(item: MediaItem(id: 1, title: "가나다라마바사아자파카ㅏ-- 하", posterUrl: nil))
}
