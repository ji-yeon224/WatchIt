//
//  TabBarItem.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import SwiftUI

struct TabBarItem: View {
    
    @Binding var curTab: Int
    var title: String
    var tab: Int
    
    var body: some View {
        Button {
            curTab = tab
        } label: {
            VStack {
                Spacer()
                if curTab == tab {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                } else {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                }
            }
            .animation(.spring(), value: curTab)
        }
        .buttonStyle(.plain)
    }
}

//#Preview {
//    TabBarItem(curTab: <#T##Binding<Int>#>, title: <#T##String#>, tab: <#T##Int#>)
//}
