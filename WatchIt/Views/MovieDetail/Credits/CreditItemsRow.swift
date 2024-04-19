//
//  CreditItemsRow.swift
//  WatchIt
//
//  Created by 김지연 on 4/18/24.
//

import SwiftUI

struct CreditItemsRow: View {
    var title: String = ""
    var creditItems: [Cast] = []
    
    var body: some View {

        
        
        ScrollView {
            
            LazyVStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(Constants.FontStyle.title.style)
                
                ForEach(creditItems) {
                    CreditItem(castItem: $0)
                }
            }
           
        }
        .padding(20)
        
        
    }
}

#Preview {
    CreditItemsRow(title: "출연", creditItems: [
        Cast(id: 1, name: "111", profilePath: nil, character: "111"), Cast(id: 2, name: "111", profilePath: nil, character: "111")
    ])
}
