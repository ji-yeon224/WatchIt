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
    var average: Double = 0.0
    var body: some View {
        
        Chart {
            ForEach(chartData, id: \.id) { item in
                BarMark(
                    x: .value("별점", item.rate),
                    y: .value("count", item.count), width: 20
                )
                .foregroundStyle(Color.yellow.gradient)
            }
            
        }
        .chartXAxis {
            AxisMarks(values: .automatic) {
                
                AxisGridLine()
                AxisValueLabel()
            }
        }
        .chartYAxis(.hidden)
        .chartXScale(domain: 0.5...5.5)
        .frame(height: 200)
        .padding()
    }
}

#Preview {
    ChartView()
}
