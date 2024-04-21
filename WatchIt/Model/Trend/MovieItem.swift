//
//  Movie.swift
//  WatchIt
//
//  Created by 김지연 on 4/12/24.
//

import Foundation
import SwiftUI

struct MovieItem: Identifiable, Hashable {
    let id: Int
    let title: String
    let posterUrl: String?
    
}
