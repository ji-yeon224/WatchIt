//
//  CreditView.swift
//  WatchIt
//
//  Created by 김지연 on 4/19/24.
//

import SwiftUI

struct CreditView: View {
    var creditItems: CreditItems = CreditItems(title: "", items: [])
    
    var body: some View {
        
        VStack {
            NavigationLink {
                CreditItemsRow(creditItems: creditItems)
            } label: {
                HStack {
                    
                    Text(creditItems.title)
                        .font(Constants.FontStyle.title2.style)
                        .frame(alignment: .leading)
                        .foregroundStyle(.black)
                    Spacer()
                    Image(.rightArrow)
                        .padding(.trailing, 5)
                }
            }

//            NavigationLink(value: creditItems) {
//                HStack {
//                    
//                    Text(creditItems.title)
//                        .font(Constants.FontStyle.title.style)
//                        .frame(alignment: .leading)
//                        .foregroundStyle(.black)
//                    Spacer()
//                    Image(.rightArrow)
//                        .padding(.trailing, 5)
//                }
//            }
//            .navigationDestination(for: CreditItems.self) { item in
//                CreditItemsRow(creditItems: item)
//            }
            
            
            
            if creditItems.items.count >= 3 {
                ForEach(0..<3) { i in
                    CreditItem(castItem: creditItems.items[i])
                }
            } else {
                ForEach(creditItems.items) { item in
                    CreditItem(castItem: item)
                }
            }
        }
        
        
        
        
    }
}

//#Preview {
//    CreditView(title: "")
//}
