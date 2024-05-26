//
//  RealmRepository.swift
//  WatchIt
//
//  Created by 김지연 on 5/21/24.
//

import Foundation
protocol DatabaseProtocol {
    associatedtype Model
    associatedtype Entity
    
    func fetchAll() -> [Entity]
    func create(data: Model) throws
    func fetchItemById(id: String) -> Model?
    func delete(id: String) throws
}
