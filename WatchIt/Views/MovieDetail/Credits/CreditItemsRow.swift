//
//  CreditItemsRow.swift
//  WatchIt
//
//  Created by 김지연 on 4/18/24.
//

import SwiftUI

struct CreditItemsRow: View {
    @StateObject private var viewModel = CreditViewModel()
    var id: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("출연진")
                .font(Constants.FontStyle.title.style)
                .frame(alignment: .leading)
            
            LazyVStack(alignment: .leading, spacing: 10) {
                
                ForEach(viewModel.castItems) { item in
                    CreditItem(castItem: item)
                }
            }

        }
        .onAppear() {
            if let id = id {
                viewModel.getCredits(type: .movie, id: id)
            }
            

        }
        
    }
}

#Preview {
    CreditItemsRow(id: 693134)
}
