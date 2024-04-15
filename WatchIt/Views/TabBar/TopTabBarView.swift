//
//  TopTabBarView.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import SwiftUI

struct TopTabBarView: View {
    @Binding var curTab: Int
    var tabBarOptions: [String] = ["MOVIE", "TV"]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tabBarOptions.indices, id: \.self) { index in
                    let title = tabBarOptions[index]
                    TabBarItem(curTab: $curTab, title: title, tab: index)
                }
            }
            
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 10))
        .frame(height: 50)
    }
}

#Preview {
    @State var tab = 0
    return TopTabBarView(curTab: $tab)
}
