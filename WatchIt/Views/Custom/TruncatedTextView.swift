//
//  TruncatedTextView.swift
//  WatchIt
//
//  Created by 김지연 on 4/17/24.
//

import SwiftUI

struct TruncatedTextView: View {
    private var text: String = ""
    private var lineLimit: Int = 1
    
    @State private var isTruncated: Bool? = nil
    @State private var isExpended: Bool = false
    
    init(text: String, lineLimit: Int) {
        self.text = text
        self.lineLimit = lineLimit
    }
    
    private func calculateTruncation() -> some View {
        ViewThatFits(in: .vertical) {
            Text(text)
                .font(Constants.FontStyle.caption.style)
                .hidden()
                .onAppear {
                    guard isTruncated == nil else { return }
                    isTruncated = false
                }
            
            Color.clear
                .hidden()
                .onAppear {
                    guard isTruncated == nil else { return }
                    isTruncated = true
                }
        }
    }
    
    var body: some View {
        Text(text)
            .font(Constants.FontStyle.caption.style)
            .lineLimit(isExpended ? nil : lineLimit)
            .frame(alignment: .leading)
            .background(calculateTruncation())
            .multilineTextAlignment(.leading)
            .overlay(alignment: .bottomTrailing) {
                if isTruncated == true && !isExpended {
                    Text(" ..더보기")
                        .font(Constants.FontStyle.caption.style)
                        .foregroundStyle(.blue)
                        .underline()
                        .onTapGesture {
                            self.isExpended.toggle()
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color(white: 1, opacity: 0.8), .white]), startPoint: .leading, endPoint: .trailing)
                                )
                        }
                        .padding(.trailing, -5)
                }
                
                
            }
    }
}

#Preview {
    TruncatedTextView(text: "황제의 모략으로 멸문한 가문의 유일한 후계자 폴. 어머니 레이디 제시카와 간신히 목숨만 부지한 채 사막으로 도망친다. 그곳에서 만난 반란군들과 숨어 지내다 그들과 함께 황제의 모든 것을 파괴할 전투를 준비한다. 한편 반란군들의 기세가 높아질수록 불안해진 황제와 귀족 가문은 잔혹한 암살자 페이드 로타를 보내 반란군을 몰살하려 하는데…", lineLimit: 2)
}
