//
//  MovieDetailResDto.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import Foundation

struct MovieDetailResDto: ResponseProtocol {
    typealias ResponseType = DetailMedia
    
    let backdropPath: String?
    let genres: [Genre]
    let id: Int
    let originalTitle, overview: String
    let posterPath: String?
    let releaseDate: String
    let runtime: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case title
    }
}

// MARK: - Genre
struct Genre: Decodable {
    let id: Int
    let name: String
}

extension MovieDetailResDto {
    func toDomain() -> DetailMedia {
        let info: String = "\(releaseDate.releaseYear ?? "") | \(genres.map { $0.name }.joined(separator: ", ")) | \(runtime)"
        var backdropUrl: String? = nil
        var posterUrl: String? = nil
        if let backdropPath = backdropPath {
            backdropUrl = BaseURL.imgURL + backdropPath
        }
        if let posterPath = posterPath {
            posterUrl = BaseURL.imgURL + posterPath
        }
        return .init(id: id, title: title, overView: overview, backdropUrl: backdropUrl, posterUrl: posterUrl, info: info)
    }
}

