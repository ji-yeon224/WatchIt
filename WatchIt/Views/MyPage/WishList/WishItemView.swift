//
//  WishItemView.swift
//  WatchIt
//
//  Created by 김지연 on 5/23/24.
//

import SwiftUI

struct WishItemView: View {
    var type: MediaType = .movie
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 3)
    var body: some View {
        Text("hello")
            .customNavBackButton()
    }
}

#Preview {
    WishItemView()
}
