//
//  TvListDto.swift
//  WatchIt
//
//  Created by 김지연 on 4/21/24.
//

import Foundation

struct TvListResDto: ResponseProtocol {
    
    typealias ResponseType = MediaItemList
    let page: Int
    let results: [TvItemResDto]
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


struct TvItemResDto: Decodable {
    let id: Int
    let posterPath: String?
    let adult: Bool
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case adult, name
    }
}

extension TvItemResDto {
    func toDomain() -> MediaItem {
        var posterUrl: String?
        if let posterPath = posterPath {
            posterUrl = BaseURL.imgURL + posterPath
        } else {
            posterUrl = nil
        }
        return .init(id: id, title: name, posterUrl: posterUrl)
    }
}
