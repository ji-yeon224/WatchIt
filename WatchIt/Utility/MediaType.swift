//
//  MediaType.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import Foundation
enum MediaType: String, CaseIterable {
    case movie
    case tv
    
    var buttonTitle: String {
        switch self {
        case .movie:
            return "영화"
        case .tv:
            return "TV"
        }
    }
}
