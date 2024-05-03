//
//  MediaItem.swift
//  WatchIt
//
//  Created by 김지연 on 4/21/24.
//

import Foundation
struct MediaItem: Hashable, Identifiable {
    let id: Int
    let title: String
    let posterUrl: String?
    let starRate: Double
    
}

struct MediaItemList: ModelTypeProtocol {
    let page: Int
    let results: [MediaItem]
    let totalPages, totalResults: Int
}

typealias MediaItems = [MediaItem]

extension MediaItem {
    
}
