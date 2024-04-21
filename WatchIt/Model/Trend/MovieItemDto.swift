//
//  TrendResDto.swift
//  WatchIt
//
//  Created by 김지연 on 4/13/24.
//

import Foundation

struct MovieListDto: Decodable {
    let page: Int
    let results: [MovieItemDto]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieItemDto: Decodable {
    let id: Int
    let posterPath: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
    }
}

extension MovieItemDto {
    func toDomain() -> MovieItem {
        return .init(id: id, title: title, posterUrl: posterPath)
    }
}
