//
//  BackDropImage.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import SwiftUI
import Kingfisher

struct BackDropImage: View {
    var url: String
    var body: some View {
        KFImage(URL(string: url))
            .onFailure { error in
                print(error)
            }
            .resizable()
            .scaledToFit()
            .overlay(Color.black.opacity(0.4))
            .clipped()
        
    }
        
}

#Preview {
    BackDropImage(url: BaseURL.imgURL+"/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg")
}
