//
//  ChartView.swift
//  WatchIt
//
//  Created by 김지연 on 5/9/24.
//

import SwiftUI
import Charts


struct ChartView: View {
    
    var chartData: [ChartData] = []
    
    var body: some View {
        
        Chart(chartData, id: \.id) { item in
            BarMark(
                x: .value("별점", item.rate),
                y: .value("count", item.count), width: 18)
            
        }
        .chartXScale(domain: 0...5)
        .frame(height: 200)
    }
}

#Preview {
    ChartView()
}
