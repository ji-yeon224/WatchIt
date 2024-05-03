//
//  TrendResDto.swift
//  WatchIt
//
//  Created by 김지연 on 4/13/24.
//

import Foundation

struct MovieListResDto: ResponseProtocol {
    
    
    typealias ResponseType = MediaItemList
    
    let page: Int
    let results: [MovieItemDto]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    func toDomain() -> MediaItemList {
        return .init(page: page, results: results.map { $0.toDomain() }, totalPages: totalPages, totalResults: totalResults)
    }
}

// MARK: - Result
struct MovieItemDto: Decodable {
    typealias ResponseType = MediaItem
    
    let id: Int
    let posterPath: String?
    let title: String

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
    }
}

extension MovieItemDto {
    
    func toDomain() -> MediaItem {
        var posterUrl: String?
        if let posterPath = posterPath {
            posterUrl = BaseURL.imgURL + posterPath
        } else {
            posterUrl = nil
        }
        return .init(id: id, title: title, posterUrl: posterUrl, starRate: 0.0)
    }
}
