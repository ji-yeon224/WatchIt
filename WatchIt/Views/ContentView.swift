//
//  ContentView.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import SwiftUI
import ComposableArchitecture

enum TabTag {
    case home
    case search
    case mypage
}

struct ContentView: View {
    
    let store: StoreOf<ContentFeature>
    @State private var selected: TabTag = .home
    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                TabView(selection: $selected) {
                    MainMediaListView(tabStore: store)
                        .tabItem {
                            selected == .home ? Image(.mainSelected) : Image(.mainUnselected)
                        }
                        .tag(TabTag.home)
                    SearchView(store: store.scope(state: \.searchTab, action: \.searchTab))
                        .tabItem {
                            selected == .search ? Image(.searchSelected) : Image(.searchUnselected)
                        }
                        .tag(TabTag.search)
                    MyPageView(store: store.scope(state: \.mypage, action: \.mypage))
                        .tabItem {
                            selected == .mypage ? Image(.myPageSelected) : Image(.myPageUnselected)
                        }
                        .tag(TabTag.mypage)
                }
            }
        }
        
        
    }
    
    var tabbar: some View {
        HStack {
            Button {
                selected = .home
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .home {
                        Text("View A")
                            .font(.system(size: 11))
                    }
                }
            }
            
            Image(systemName: "star")
            Image(systemName: "star")
        }
        .frame(width: .infinity, height: 200)
        .cornerRadius(5)
        .shadow(radius: 5)
    }
}

#Preview {
    ContentView(store: Store(initialState: ContentFeature.State(), reducer: {
        ContentFeature()
    }))
}
