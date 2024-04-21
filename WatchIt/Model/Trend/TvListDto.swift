//
//  TvListDto.swift
//  WatchIt
//
//  Created by 김지연 on 4/21/24.
//

import Foundation

struct TvListDto: Decodable {
    let page: Int
    let results: [TvItemDto]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


struct TvItemDto: Decodable {
    let id: Int
    let posterPath: String
    let adult: Bool
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case adult, name
    }
}

extension TvItemDto {
    func toDomain() -> MediaItem {
        return .init(id: id, title: name, posterUrl: posterPath)
    }
}
