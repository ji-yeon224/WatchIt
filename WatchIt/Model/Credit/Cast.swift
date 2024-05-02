//
//  Cast.swift
//  WatchIt
//
//  Created by 김지연 on 4/18/24.
//

import Foundation

//struct Cast: Hashable {
//    let id: Int
//    let name: String
//    let profilePath: String?
//    let character: String
//    
//}

struct Cast: Identifiable, ModelTypeProtocol {
    let _id = UUID()
    let id: Int
    let name: String
    let profilePath: String?
    let character: String
    
}

struct CastList: ModelTypeProtocol {
    let id: Int
    let cast: [Cast]
    let crew: [Cast]
}

