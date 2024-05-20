//
//  FilterStateType.swift
//  WatchIt
//
//  Created by 김지연 on 5/20/24.
//

import Foundation
enum FilterState: CaseIterable {
    case ascending
    case descending
    
    var pickerTitle: String {
        switch self {
        case .ascending:
            return "별점 높은 순"
        case .descending:
            return "별점 낮은 순"
        }
    }
}
