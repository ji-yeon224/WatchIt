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
        
        HStack {
            Text(title.rawValue)
                .font(Constants.FontStyle.subtitle.style)
            Spacer()
            Image(.rightArrow)
        }
        .frame(height: 40)
        
    }
}

#Preview {
    RatedListRow()
}
