//
//  CreditResDto.swift
//  WatchIt
//
//  Created by 김지연 on 4/18/24.
//

import Foundation



struct CreditResDto: Codable {
    let id: Int
    let cast, crew: [CastResDto]
}


struct CastResDto: Codable {
    let id: Int
    let knownForDepartment: Department
    let name: String
    let profilePath: String?
    let character: String?
    let order: Int?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case id
        case knownForDepartment = "known_for_department"
        case name
        case profilePath = "profile_path"
        case character
        case order, job
    }
}

enum Department: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}


extension CastResDto {
    func toDomain() -> Cast {
        var profileUrl: String?
        if let profilePath = profilePath {
            profileUrl = BaseURL.imgURL + profilePath
        } else {
            profileUrl = nil
        }
        return .init(id: id, department: knownForDepartment, name: name, profilePath: profileUrl, character: character, order: order, job: job)
    }
}
