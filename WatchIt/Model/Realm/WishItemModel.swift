//
//  WishItemModel.swift
//  WatchIt
//
//  Created by 김지연 on 5/21/24.
//

import Foundation
import RealmSwift

final class WishItemModel: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var mediaId: Int
    @Persisted var title: String
    @Persisted var posterPath: String?
    @Persisted var mediaType: String
    
    convenience init(id: String, mediaId: Int, title: String, posterPath: String? = nil, mediaType: String) {
        self.init()
        self.id = id
        self.mediaId = mediaId
        self.title = title
        self.posterPath = posterPath
        self.mediaType = mediaType
    }
    
    func toDomain() -> MediaItem {
        return .init(id: mediaId, title: title, posterUrl: posterPath, starRate: 0.0)
    }
}
