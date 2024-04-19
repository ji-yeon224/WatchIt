//
//  CreditItemsRow.swift
//  WatchIt
//
//  Created by 김지연 on 4/18/24.
//

import SwiftUI

struct CreditItemsRow: View {
    private var creditItems: CreditItems = CreditItems(title: "", items: [])
    
    init(creditItems: CreditItems) {
        self.creditItems = creditItems
    }
    
    var body: some View {

        
        ScrollView {
            
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(creditItems.items, id: \._id) {
                    CreditItem(castItem: $0)
                }
            }
           
        }
        .navigationTitle(creditItems.title)
        .padding(20)
        .customNavBackButton()
        
        
    }
}

//#Preview {
//    CreditItemsRow(title: "", creditItems: [
//        Cast(id: 1, name: "111", profilePath: nil, character: "111"), Cast(id: 2, name: "111", profilePath: nil, character: "111")
//    ])
//}
