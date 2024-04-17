//
//  MovieDetailResDto.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import Foundation

struct MovieDetailResDto: Decodable {
    let backdropPath: String
    let genres: [Genre]
    let id: Int
    let originalTitle, overview: String
    let posterPath: String
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
    func toDomain() -> DetailMovie {
        return .init(id: id, title: title, originalTitle: originalTitle, overView: overview, backdropUrl: BaseURL.imgURL+backdropPath, posterUrl: BaseURL.imgURL+posterPath, runtime: runtime.runtimeToStr, releaseYear: releaseDate.releaseYear, releaseDate: releaseDate, genres: genres.map { $0.name })
    }
}

