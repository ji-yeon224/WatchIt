//
//  TvDetailResDto.swift
//  WatchIt
//
//  Created by 김지연 on 4/22/24.
//

import Foundation
struct TvDetailResDto: Decodable {
    let backdropPath: String?
    let firstAirDate: String
    let genres: [Genre]
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genres, id
        case name
        case overview
        case posterPath = "poster_path"
    }
}

extension TvDetailResDto {
    func toDomain() -> DetailMedia {
        let info: String = "\(firstAirDate.releaseYear ?? "") | \(genres.map { $0.name }.joined(separator: ", "))"
        var backdropUrl: String? = nil
        var posterUrl: String? = nil
        if let backdropPath = backdropPath {
            backdropUrl = BaseURL.imgURL + backdropPath
        }
        if let posterPath = posterPath {
            posterUrl = BaseURL.imgURL + posterPath
        }
        return .init(id: id, title: name, overView: overview, backdropUrl: backdropUrl, posterUrl: posterUrl, info: info)
    }
}
