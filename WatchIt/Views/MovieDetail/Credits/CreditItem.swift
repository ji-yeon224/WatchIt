//
//  CreditItem.swift
//  WatchIt
//
//  Created by 김지연 on 4/18/24.
//

import SwiftUI

struct CreditItem: View {
    
    private var castItem: Cast?
    
    init(castItem: Cast?) {
        self.castItem = castItem
    }
    
    var body: some View {
        if let castItem = castItem {
            HStack {
                ProfileImage(url: castItem.profilePath)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading) {
                    Text(castItem.name)
                        .font(Constants.FontStyle.boldPlain.style)
                    Text(castItem.character)
                        .font(Constants.FontStyle.caption.style)
                }
                Spacer()
            }
        }
        
        
    }
}

#Preview {
    let cast = Cast(id: 1, name: "Timothée Chalamet", profilePath: BaseURL.imgURL+"/BE2sdjpgsa2rNTFa66f7upkaOP.jpg", character: "Paul Atreides")
    return CreditItem(castItem: cast)
}
