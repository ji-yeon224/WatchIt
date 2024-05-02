//
//  StarRatingView.swift
//  WatchIt
//
//  Created by 김지연 on 5/2/24.
//

import SwiftUI
import AxisRatingBar

struct StarRatingView: View {
    
    @Binding var value: CGFloat
    private let starCount: CGFloat = 5
    private let innerRatio: CGFloat = 0.8
    
    private let constant = ARConstant(rating: 5,
                               size: CGSize(width: 40, height: 40),
                               spacing: 6,
                               fillMode: .half,
                               axisMode: .horizontal,
                               valueMode: .point)
    var body: some View {
        
        AxisRatingBar(value: $value, constant: constant) {
            ARStar(count: round(starCount), innerRatio: innerRatio)
                .fill(.secondaryBg)
                .shadow(radius: 1)
        } foreground: {
            ARStar(count: round(starCount), innerRatio: innerRatio)
                .fill(.yellow)
        }
        
    }
}

#Preview {
    StarRatingView(value: .constant(1.0))
}
