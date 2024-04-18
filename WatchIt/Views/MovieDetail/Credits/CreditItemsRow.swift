//
//  CreditItemsRow.swift
//  WatchIt
//
//  Created by 김지연 on 4/18/24.
//

import SwiftUI

struct CreditItemsRow: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("출연진")
                .font(Constants.FontStyle.title.style)
                .frame(alignment: .leading)
            LazyVStack(alignment: .leading, spacing: 10) {
                CreditItem()
                CreditItem()
                CreditItem()
            }
            .padding(.leading, 10)
        }
        
    }
}

#Preview {
    CreditItemsRow()
}
