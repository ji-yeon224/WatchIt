//
//  DetailMovie.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import Foundation

struct DetailMovie: Hashable {
    let id: Int
    let title: String
    let originalTitle: String
    let overView: String
    let backdropUrl: String
    let posterUrl: String
    let runtime: String
    let releaseYear: String?
    let releaseDate: String
    let genres: [String]
    
    var info: String {
        return "\(releaseYear ?? "") | \(genres.joined(separator: ", ")) | \(runtime)"
    }
    
    
}
