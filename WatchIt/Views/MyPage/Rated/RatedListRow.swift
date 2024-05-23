//
//  RatedListRow.swift
//  WatchIt
//
//  Created by 김지연 on 5/13/24.
//

import SwiftUI

struct RatedListRow: View {
    var title: MediaType = .movie
    
    var body: some View {
        NavigationLink(value: title) {
            HStack {
                Text(title.title)
                    .font(Constants.FontStyle.subtitle.style)
                Spacer()
                Image(.rightArrow)
                
                
            }
        }
        .foregroundStyle(.black)
        .frame(height: 40)
        
        
        
    }
}

#Preview {
    RatedListRow()
}
