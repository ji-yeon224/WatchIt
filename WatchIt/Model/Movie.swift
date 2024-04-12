//
//  Movie.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import Foundation
import SwiftUI

struct Movie: Identifiable {
    let id: Int
    let title: String
    var image: Image {
        Image(.movieImg)
    }
}
