//
//  MovieInfoView.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import SwiftUI

struct MovieInfoView: View {
    var details: DetailMovie?
    
    var body: some View {
        if let details = details {
            VStack(alignment: .leading) {
                ZStack(alignment: .bottomLeading) {
                    BackDropImage(url: details.backdropUrl)
                        
                    HStack(alignment: .bottom, spacing: 10) {
                        PosterImage(url: details.posterUrl)
                            .shadow(radius: 5)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: -30, trailing: 0))
                        Text(details.title)
                            .font(Constants.FontStyle.title.style)
                            .foregroundStyle(.white)
                            .padding([.trailing, .bottom], 8)
                    }
                    
                }
                
                Text(details.info)
                    .font(Constants.FontStyle.plain.style)
                    .padding(.leading, 120)
                
            }
            
        }
        
    }
}

#Preview {
    let detail = DetailMovie(id: 693134, title: "듄", originalTitle: "", overView: "", backdropUrl: BaseURL.imgURL + "/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg", posterUrl: BaseURL.imgURL +  "/8uUU2pxm6IYZw8UgnKJyx7Dqwu9.jpg", runtime: "2시간 47분", releaseYear: "2024", releaseDate: "", genres: ["SF", "모험"])
    return MovieInfoView(details: detail)
}
