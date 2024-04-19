//
//  Constants.swift
//  WatchIt
//
//  Created by 김지연 on 4/18/24.
//

import Foundation
import SwiftUI

final class Constants { }

extension Constants {
    enum FontStyle {
        case title
        case plain
        case boldPlain
        case caption
        
        var style: Font {
            switch self {
            case .title:
                return .system(size: 17, weight: .bold)
            case .plain:
                return .system(size: 14)
            case .boldPlain:
                return .system(size: 14, weight: .bold)
            case .caption:
                return .system(size: 12)
            }
        }
    }
}
