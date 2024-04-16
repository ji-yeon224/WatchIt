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
        
        VStack(alignment: .leading) {
            
            BackDropImage(url: details?.backdropUrl)
                .overlay(alignment: .leading) {
                    HStack {
                        PosterImage(url: details?.posterUrl)
                            .padding(10)
                        VStack(alignment: .leading) {
                            if let details = details {
                                Text(details.title)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 5)
                                Text(details.info)
                                    .font(.system(size: 14))
                            }
                            
                        }
                        .offset(x: -10, y: 40)
                        
                    }
                    .offset(y: 68)
                    
                }
            
            Spacer()
        }
    }
}

//#Preview {
//    MovieInfoView(de)
//}
