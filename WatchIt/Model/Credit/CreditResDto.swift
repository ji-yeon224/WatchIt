//
//  CreditResDto.swift
//  WatchIt
//
//  Created by 김지연 on 4/18/24.
//

import Foundation



struct CreditResDto: ResponseProtocol {
    
    typealias ResponseType = CastList
    
    let id: Int
    let cast: [CastResDto]
    let crew: [CrewResDto]
    
    func toDomain() -> CastList {
        return .init(id: id, cast: cast.map { $0.toDomain() }, crew: crew.map { $0.toDomain() })
    }
}


struct CastResDto: Decodable {
    let id: Int
    let name: String
    let profilePath: String?
    let character: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case character
    }
}

struct CrewResDto: Decodable {
    let id: Int
    let department: String
    let name: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case department = "known_for_department"
        case name
        case profilePath = "profile_path"
    }
}


extension CastResDto {
    func toDomain() -> Cast {
        var profileUrl: String?
        if let profilePath = profilePath {
            profileUrl = BaseURL.imgURL + profilePath
        } else {
            profileUrl = nil
        }
        return .init(id: id, name: name, profilePath: profileUrl, character: character)
    }
}
extension CrewResDto {
    func toDomain() -> Cast {
        var profileUrl: String?
        if let profilePath = profilePath {
            profileUrl = BaseURL.imgURL + profilePath
        } else {
            profileUrl = nil
        }
        return .init(id: id, name: name, profilePath: profileUrl, character: department)
    }
}
