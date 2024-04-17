//
//  BackDropImage.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import SwiftUI
import Kingfisher

struct BackDropImage: View {
    var url: String?
    var body: some View {
        if let url = url {
            KFImage(URL(string: url))
                .placeholder({
                    ProgressView()
                        .configBackdropImgRatio()
                })
                .onFailure { error in
                    print(error)
                }
                .resizable()
                .configBackdropImgRatio()
                .overlay(Color.black.opacity(0.4))
                .clipped()
        } else {
            Rectangle()
                .configBackdropImgRatio()
                .foregroundStyle(.gray)
        }
        
        
    }
        
}

#Preview {
    BackDropImage(url: BaseURL.imgURL+"/b4xaqpUZFUkgyJ1VcFEPXmDML34.jpg")
}
