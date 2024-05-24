//
//  MovieView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI
import Combine
import Kingfisher

struct MediaItemVerticalView: View {
    var item: MediaItem
    var starRate: Double = 0.0
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            if let url = item.posterUrl {
                PosterImage(url: url)

            } else {
                
                Rectangle()
                    .frame(width: 100, height: 150)
                    .foregroundStyle(.gray)
            }
            Text(item.title)
                .font(Constants.FontStyle.plain.style)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 100, alignment: .topLeading)
            if starRate > 0.0 {
                starRateText
            }
            
        }
    }
    
    private var starRateText: some View {
        HStack(spacing: 4) {
            Image(.yelloStar)
                .resizable()
                .frame(width: 14, height: 14)
            Text("\(starRate.makeStarRate)점")
                .font(Constants.FontStyle.boldPlain.style)
                .foregroundStyle(.customYellow)
        }
    }
        
}

#Preview {
    MediaItemVerticalView(item: MediaItem(id: 1, title: "가나다라마바사아자파카ㅏ-- 하", posterUrl: nil, starRate: 0.0))
}
