//
//  DetailMovie.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import Foundation

struct DetailMedia: ModelTypeProtocol {
    let id: Int
    let title: String
    let overView: String
    let backdropUrl: String?
    let posterUrl: String?
    let info: String
    
//    func toRecord(key: String, type: MediaType) -> StarRatedItemModel {
//        return .init(id: key, mediaId: id, title: title, posterPath: posterUrl, mediaType: type.rawValue, starRate: starRate)
//    }
//    var info: String {
//        return "\(releaseYear ?? "") | \(genres.joined(separator: ", ")) | \(runtime)"
//    }
    
    
}
