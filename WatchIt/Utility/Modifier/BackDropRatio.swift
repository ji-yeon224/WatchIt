//
//  BackDropRatio.swift
//  WatchIt
//
//  Created by 김지연 on 4/17/24.
//

import SwiftUI

private struct BackDropRatio: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: .infinity)
            .aspectRatio(16/9, contentMode: .fit)
    }
}

extension View {
    func configBackdropImgRatio() -> some View {
        modifier(BackDropRatio())
    }
}
