//
//  TrendResDto.swift
//  WatchIt
//
//  Created by 김지연 on 4/13/24.
//

import Foundation

struct TrendsResDto: Decodable {
    let page: Int
    let results: [TrendResDto]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TrendResDto: Decodable {
    let backdropPath: String
    let id: Int
    let originalTitle, overview, posterPath: String
    let title: String
    let releaseDate: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

extension TrendResDto {
    func toDomain() -> Movie {
        return .init(id: id, title: title, posterUrl: posterPath, backDropUrl: backdropPath, releaseDate: releaseDate)
    }
}
