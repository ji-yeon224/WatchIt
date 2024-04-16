//
//  Int+Extension.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import Foundation
extension Int {
    var runtimeToStr: String {
        let h = self / 60
        let m = self % 60
        
        return h > 0 ? "\(h)시간 \(m)분" : "\(m)분"
    }
}
