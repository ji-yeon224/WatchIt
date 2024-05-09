//
//  MyPageView.swift
//  WatchIt
//
//  Created by 김지연 on 5/9/24.
//

import SwiftUI
import ComposableArchitecture

struct MyPageView: View {
    
    var store: StoreOf<MyPageFeature>
    
    
    var body: some View {
        WithPerceptionTracking {
            VStack{
                let _ = print(store.chartData)
                ChartView(chartData: store.chartData)
            }
            .onAppear() {
                store.send(.requestRateData)
            }
                
        }
        
        
    }
        
        
}

#Preview {
    MyPageView(store: Store(initialState: MyPageFeature.State()) {
        MyPageFeature()
    })
}
