//
//  MediaItemRepository.swift
//  WatchIt
//
//  Created by 김지연 on 5/3/24.
//

import Foundation
import RealmSwift


final class StarRatedRepository: DatabaseProtocol {
    
    typealias Model = StarRatedItemModel
    typealias Entity = MediaItem
    
    private let realm = try! Realm()
    
    func fetchAll() -> [Entity] {
        return Array(realm.objects(StarRatedItemModel.self)).map { $0.toDomain() }
    }
    
    func create(data: StarRatedItemModel) throws {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            throw DBError.createError
        }
    }
    
    func updateRate(object: StarRatedItemModel, starRate: Double) throws {
        do {
            try realm.write {
                object.starRate = starRate
                realm.add(object)
            }
        } catch {
            throw DBError.createError
        }
        
    }
    
    func fetchItemById(id: String) -> StarRatedItemModel? {
        return realm.object(ofType: StarRatedItemModel.self, forPrimaryKey: id)
        
    }
    
    func fetchItemByMediaType(type: String, ascending: Bool) -> [Entity] {
        return realm.objects(StarRatedItemModel.self)
            .where {
            $0.mediaType == type
            }
            .sorted(byKeyPath: "starRate", ascending: ascending)
            .map { $0.toDomain() }
    }
    
    func getStarRate(id: String) -> Double {
        
        return fetchItemById(id: id)?.starRate ?? 0
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
    
    func getRateCount(rate: Double) -> Int {
        return realm.objects(StarRatedItemModel.self).where {
            $0.starRate == rate
        }.count
    }
    
    
    
    
    func getLocation() {
        print("=====Realm 경로: ", realm.configuration.fileURL!)
    }
    
    
    
}
