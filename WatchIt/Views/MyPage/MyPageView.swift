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
            NavigationStack {
                VStack(alignment: .leading){
    //                let _ = print(store.chartData)
                    Text("나의 별점 분포")
                        .font(Constants.FontStyle.title1.style)
                        
                    ChartView(chartData: store.chartData, average: store.averageRate)
                        .padding()
                    Divider()
                        .frame(height: 20)
                    RatedListView(store: store)
                    
                    Spacer()
                }
                .padding()
                
                .navigationTitle("My Page")
                .navigationBarTitleDisplayMode(.large)
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
