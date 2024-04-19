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
    @State private var castItems: [Cast] = []
    @State private var crewItems: [Cast] = []
    var body: some View {
        
        VStack(alignment: .leading) {
            if viewModel.castCnt > 0 {
                
                
                LazyVStack(alignment: .leading, spacing: 10) {
                    
                    Text("출연진")
                        .font(Constants.FontStyle.title.style)
                        .frame(alignment: .leading)
                    
                    if viewModel.castCnt >= 3 {
                        ForEach(0..<3) { i in
                            CreditItem(castItem: viewModel.castItems[i])
                        }
                    } else {
                        ForEach(castItems) { item in
                            CreditItem(castItem: item)
                        }
                    }
                    
                    
                    
                }
                .padding(.bottom, 10)
                Divider()
            }
            
            if viewModel.crewCnt > 0 {
                
                
                LazyVStack(alignment: .leading, spacing: 10) {
                    Text("제작")
                        .font(Constants.FontStyle.title.style)
                        .frame(alignment: .leading)
                    
                    if viewModel.crewCnt >= 3 {
                        ForEach(0..<3) { i in
                            CreditItem(castItem: viewModel.crewItems[i])
                        }
                    } else {
                        ForEach(crewItems) { item in
                            CreditItem(castItem: item)
                        }
                    }
                }
                .padding(.vertical, 10)
            }
            
            
            

        }
        .onAppear() {
            if let id = id {
                viewModel.getCredits(type: .movie, id: id)
                castItems = viewModel.castItems
                crewItems = viewModel.crewItems
            }
            

        }
        
    }
}

#Preview {
    CreditItemsRow(id: 693134)
}
