//
//  MyPageView.swift
//  WatchIt
//
//  Created by 김지연 on 5/9/24.
//

import SwiftUI
import ComposableArchitecture
enum MyPageDestination: Hashable {
    case wish(MediaType)
    case rate(MediaType)
}
struct MyPageView: View {
    
    var store: StoreOf<MyPageFeature>
    
    
    var body: some View {
        WithPerceptionTracking {
            
            NavigationStack {
                ScrollView {
                    
                    VStack(alignment: .leading){
                        WishListView()
                        Divider()
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
                    .navigationBarTitleDisplayMode(.large)
                    .navigationTitle("My Page")
                    .navigationDestination(for: MyPageDestination.self) { dest in
                        switch dest {
                        case let .wish(type):
                            WithPerceptionTracking {
                                WishItemGridView(type: type, store: WatchItApp.store.scope(state: \.wish, action: \.wish))
                            }
                            
                        case let .rate(type):
                            WithPerceptionTracking {
                                RatedItemGridView(store: Store(initialState: RatedItemFeature.State()) {
                                    RatedItemFeature() }, type: type )
                            }
                        }
                        
                        
                            
                    }
                    
                }
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
