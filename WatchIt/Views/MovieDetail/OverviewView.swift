//
//  OverviewView.swift
//  WatchIt
//
//  Created by 김지연 on 4/17/24.
//

import SwiftUI

struct OverviewView: View {
    @State private var expended = false
    @State private var isTruncated: Bool? = nil
    @State private var isRendered: Bool = false
    
    private var overviewText: String? = ""
    
    init(overViewText: String?) {
        self.overviewText = overViewText
    }
    
    
    var body: some View {
        if let overviewText = self.overviewText, !overviewText.isEmpty {
            VStack(alignment: .leading, spacing: 10) {
                Text("줄거리")
                    .font(.system(size: 16))
                    .frame(alignment: .leading)
                    .bold()
                
                TruncatedTextView(text: overviewText, lineLimit: 2)
                    .frame(alignment: .leading)
                
                
                
            }
            .frame(maxWidth: .infinity)
            
        }
    }
    
    
}

#Preview {
    OverviewView(overViewText: "황제의 모략으로 멸문한 가문의 유일한 후계자 폴. 어머니 레이디 제시카와 간신히 목숨만 부지한 채 사막으로 도망친다. 그곳에서 만난 반란군들과 숨어 지내다 그들과 함께 황제의 모든 것을 파괴할 전투를 준비한다. 한편 반란군들의 기세가 높아질수록 불안해진 황제와 귀족 가문은 잔혹한 암살자 페이드 로타를 보내 반란군을 몰살하려 하는데…")
}
