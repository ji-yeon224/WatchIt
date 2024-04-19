//
//  CreditView.swift
//  WatchIt
//
//  Created by 김지연 on 4/19/24.
//

import SwiftUI

struct CreditView: View {
    var title: String = ""
    var creditItems: [Cast] = []
    
    var body: some View {
        VStack {
            Button(action: {}, label: {
                HStack {
                    Text(title)
                        .font(Constants.FontStyle.title.style)
                        .frame(alignment: .leading)
                        .foregroundStyle(.black)
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Image(.rightArrow)
                    })
                    .padding(.trailing, 5)
                }
                
            })
            
            if creditItems.count >= 3 {
                ForEach(0..<3) { i in
                    CreditItem(castItem: creditItems[i])
                }
            } else {
                ForEach(creditItems) { item in
                    CreditItem(castItem: item)
                }
            }
            
        }
        
    }
}

#Preview {
    CreditView(title: "출연")
}
