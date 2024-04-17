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
                    HStack(alignment: .bottom, spacing: 20) {
                        PosterImage(url: details.posterUrl)
                            .offset(x: 10, y: 30)
                        Text(details.title)
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding([.trailing, .bottom], 8)
                    }
                    
                }
                
                Text(details.info)
                    .font(.system(size: 14))
                    .padding(.leading, 120)
                
                Spacer()
            }
        }
        
    }
}

#Preview {
    let detail = DetailMovie(id: 693134, title: "듄afffjjㅇㅇㅇㅇㅇㅇㅇㅇㅇhjhjㄹ려ㅓㅓ히aㅁㄴㅇㄹ", originalTitle: "", overView: "", backdropUrl: BaseURL.imgURL + "/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg", posterUrl: BaseURL.imgURL +  "/8uUU2pxm6IYZw8UgnKJyx7Dqwu9.jpg", runtime: "2시간 47분", releaseYear: "2024", releaseDate: "", genres: ["SF", "모험", "액션", "판타지", "ㅁㅁㅁ"])
    return MovieInfoView(details: detail)
}
