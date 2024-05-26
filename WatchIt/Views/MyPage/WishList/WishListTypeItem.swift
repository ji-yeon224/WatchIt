//
//  WishTypeButton.swift
//  WatchIt
//
//  Created by 김지연 on 5/23/24.
//

import SwiftUI

struct WishListTypeItem: View {
    var image: ImageResource
    var title: MediaType
    var body: some View {
        NavigationLink(value: MyPageDestination.wish(title)) {
            VStack {
                Image(image)
                    .resizable()
                    .frame(width: 65, height: 65)
                Text(title.buttonTitle)
            }
        }
        .foregroundStyle(.black)
        
        
    }
}

//#Preview {
//    
//}
