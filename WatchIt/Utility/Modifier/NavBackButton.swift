//
//  NavBackButton.swift
//  WatchIt
//
//  Created by 김지연 on 4/19/24.
//

import SwiftUI

struct NavBackButton: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.black)
                    }
                    
                }
            })
    }
}

extension View {
    func customNavBackButton() -> some View {
        modifier(NavBackButton())
    }
}
