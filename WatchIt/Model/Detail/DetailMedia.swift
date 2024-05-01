//
//  DetailMovie.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import Foundation

struct DetailMedia: Hashable {
    let id: Int
    let title: String
    let overView: String
    let backdropUrl: String?
    let posterUrl: String?
    let info: String
    
//    var info: String {
//        return "\(releaseYear ?? "") | \(genres.joined(separator: ", ")) | \(runtime)"
//    }
    
    
}
