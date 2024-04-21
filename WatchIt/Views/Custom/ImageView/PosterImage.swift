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
    var body: some View {
        if let url = url {
            KFImage(URL(string: url))
                .onFailure { error in
                    print(error)
                }
                .resizable()
                .frame(width: 100, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .shadow(radius: 1)
                .foregroundStyle(.gray)
                
        }
        
    }
}

