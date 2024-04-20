//
//  MovieView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI
import Combine
import Kingfisher

struct MovieItemView: View {
    var movie: MovieItem
    
    var body: some View {
        VStack(alignment: .leading) {
            if let url = movie.posterUrl {
                PosterImage(url: BaseURL.imgURL + url)
            } else {
                
                Rectangle()
                    .frame(width: 100, height: 150)
                    .foregroundStyle(.gray)
            }
            Text(movie.title)
                .font(Constants.FontStyle.plain.style)
                .lineLimit(2)
                .frame(width: 100, alignment: .leading)
                
        }
    }
        
}

//#Preview {
//    MovieView(movie: Movie(id: 1, title: "movie"))
//}
