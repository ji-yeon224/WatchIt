//
//  ProfileImage.swift
//  WatchIt
//
//  Created by 김지연 on 4/18/24.
//

import SwiftUI
import Kingfisher

struct ProfileImage: View {
    var url: String?
    var body: some View {
        if let url = url {
            KFImage(URL(string: url))
                .cancelOnDisappear(true)
                .cacheMemoryOnly()
                .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 50 * 1.5 , height: 50 * 1.5)))
                .onFailure { error in
                    print(error)
                }
                .placeholder {
                    Image(.profile)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 50)
                }
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 50)
                .clipped()
        } else {
            Image(.profile)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 50)
                .clipped()
        }
        
    }
}

#Preview {
    ProfileImage(url: BaseURL.imgURL + "/Ats6HnzudW0GehRntAVxPCcRO.jpg")
}
