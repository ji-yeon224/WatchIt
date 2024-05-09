//
//  WatchItApp.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct WatchItApp: App {
    static let store = Store(initialState: ContentFeature.State()) {
        ContentFeature()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(store: WatchItApp.store)
        }
    }
}
