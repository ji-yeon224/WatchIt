//
//  MovieInfoView.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import SwiftUI

struct MovieInfoView: View {
    var poster: String = BaseURL.imgURL+"/8uUU2pxm6IYZw8UgnKJyx7Dqwu9.jpg"
    var backdrop: String = BaseURL.imgURL+"/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg"
    var title: String = "듄: 파트 2"
    
    
    var body: some View {
        VStack(alignment: .leading) {
            BackDropImage(url: backdrop)
                .overlay(alignment: .leading) {
                    HStack {
                        PosterImage(url: poster)
                            .padding(10)
                        VStack(alignment: .leading) {
                            Text(title)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.bottom, 5)
                            Text("2024 | SF, 모험 | 2시간 47분")
                                .font(.system(size: 14))
                        }
                        .offset(x: -10, y: 40)
                        
                    }
                    .offset(y: 68)
                    
                }
            
            Spacer()
        }
    }
}

#Preview {
    MovieInfoView()
}
