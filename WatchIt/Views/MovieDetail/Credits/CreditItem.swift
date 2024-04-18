//
//  CreditItem.swift
//  WatchIt
//
//  Created by 김지연 on 4/18/24.
//

import SwiftUI

struct CreditItem: View {
    var body: some View {
        HStack {
            Image(.profile)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 50)
            VStack(alignment: .leading) {
                Text("name")
                    .font(Constants.FontStyle.boldPlain.style)
                Text("nameaaa")
                    .font(Constants.FontStyle.caption.style)
            }
        }
        
    }
}

#Preview {
    CreditItem()
}
