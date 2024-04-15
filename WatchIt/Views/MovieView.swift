//
//  MovieView.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI
import Combine
import Kingfisher

struct MovieView: View {
    var movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: BaseURL.imgURL + movie.posterUrl!)!)
                .onFailure { error in
                    print(error)
                }
                .resizable()
                .frame(width: 100, height: 150)
                .clipped()
            Text(movie.title)
                .frame(width: 100, alignment: .leading)
                
        }
    }
        
}

//#Preview {
//    MovieView(movie: Movie(id: 1, title: "movie"))
//}
