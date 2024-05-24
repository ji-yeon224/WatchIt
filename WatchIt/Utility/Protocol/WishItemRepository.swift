//
//  WishItemRepository.swift
//  WatchIt
//
//  Created by 김지연 on 5/21/24.
//

import Foundation
import RealmSwift

final class WishItemRepository: DatabaseProtocol {
    
    typealias Model = WishItemModel
    typealias Entity = MediaItem
    
    private let realm = try! Realm()
    
    func fetchAll() -> [MediaItem] {
        return Array(realm.objects(WishItemModel.self)).map { $0.toDomain() }
    }
    
    func create(data: WishItemModel) throws {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            throw DBError.createError
        }
    }
    
    func fetchItemById(id: String) -> WishItemModel? {
        return realm.object(ofType: WishItemModel.self, forPrimaryKey: id)
    }
    
    func fetchItemByMediaType(type: String) -> [Entity] {
        return realm.objects(WishItemModel.self)
            .where {
                $0.mediaType == type
            }
            .map { $0.toDomain() }
    }
    
    func delete(id: String) throws {
        let item = fetchItemById(id: id)
        if let item = item {
            do {
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                throw DBError.deleteError
            }
        } else {
            throw DBError.fetchError
        }
    }
    
    
    func getLocation() {
        print("=====Realm 경로: ", realm.configuration.fileURL!)
    }
    
}
