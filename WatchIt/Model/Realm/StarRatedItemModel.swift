//
//  MediaItemModel.swift
//  WatchIt
//
//  Created by 김지연 on 5/3/24.
//

import Foundation
import RealmSwift

final class StarRatedItemModel: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var mediaId: Int
    @Persisted var title: String
    @Persisted var posterPath: String?
    @Persisted var mediaType: String
    @Persisted var starRate: Double
    
    convenience init(id: String, mediaId: Int, title: String, posterPath: String? = nil, mediaType: String, starRate: Double) {
        self.init()
        self.id = id
        self.mediaId = mediaId
        self.title = title
        self.posterPath = posterPath
        self.mediaType = mediaType
        self.starRate = starRate
    }
    
    func toDomain() -> MediaItem {
        return .init(id: mediaId, title: title, posterUrl: posterPath, starRate: starRate)
    }
}
