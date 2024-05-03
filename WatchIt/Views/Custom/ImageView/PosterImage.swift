//
//  PosterImage.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import SwiftUI
import Kingfisher

struct PosterImage: View {
    var url: String?
    var width: CGFloat = 100
    var height: CGFloat = 150
    var body: some View {
        if let url = url {

            KFImage(URL(string: url))
                .cancelOnDisappear(true)
                .setProcessor(DownsamplingImageProcessor(size: CGSize(width: width * 2 , height: height * 2)))
                .cacheMemoryOnly()
                .placeholder({
                    ProgressView()
                        .frame(width: width, height: height)
                })
                .onFailure { error in
                    print(error)
                }
                .resizable()
                .frame(width: width, height: height)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .shadow(radius: 1)
                .foregroundStyle(.gray)
                
        } else {
            placeholderImg
        }
        
    }
    
    @ViewBuilder
    private var placeholderImg: some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundStyle(.secondaryBg)
            .overlay(alignment: .center) {
                Image(systemName: "movieclapper")
                    .foregroundStyle(.gray)
                    
                    
            }
            .frame(width: width, height: height)
    }
}

