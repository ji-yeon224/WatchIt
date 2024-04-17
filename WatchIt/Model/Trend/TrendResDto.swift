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
    let id: Int
    let posterPath: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
    }
}

extension TrendResDto {
    func toDomain() -> MovieTrend {
        return .init(id: id, title: title, posterUrl: posterPath)
    }
}
