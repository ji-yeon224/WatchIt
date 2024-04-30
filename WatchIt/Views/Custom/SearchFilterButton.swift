//
//  SearchFilterButton.swift
//  WatchIt
//
//  Created by 김지연 on 4/30/24.
//

import SwiftUI

struct SearchFilterButton: View {
    var buttonType: MediaType = .movie
    @Binding var curFilter: MediaType
    
    var body: some View {
        Button {
            curFilter = buttonType
            
            
        } label: {
            if curFilter == buttonType {
                Text(buttonType.buttonTitle)
                    .frame(width: 50, height: 23)
                    .font(Constants.FontStyle.plain.style)
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.black)
                            .shadow(color: .black.opacity(0.3),radius: 1)
                    )
            } else {
                Text(buttonType.buttonTitle)
                    .frame(width: 50, height: 23)
                    .font(Constants.FontStyle.plain.style)
                    .foregroundStyle(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.white)
                            .shadow(color: .black.opacity(0.3),radius: 1)
                    )
            }
            
        }
        
        
    }
}

#Preview {
    SearchFilterButton(buttonType: .movie, curFilter: .constant(.movie))
}
