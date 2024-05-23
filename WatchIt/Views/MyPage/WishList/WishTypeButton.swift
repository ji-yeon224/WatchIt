//
//  WishTypeButton.swift
//  WatchIt
//
//  Created by 김지연 on 5/23/24.
//

import SwiftUI

struct WishTypeButton: View {
    var image: ImageResource
    var title: String
    var body: some View {
        VStack {
            Image(image)
            Text(title)
        }
        
    }
}

//#Preview {
//    
//}
