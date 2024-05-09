//
//  MediaItemRepository.swift
//  WatchIt
//
//  Created by 김지연 on 5/3/24.
//

import Foundation
import RealmSwift

protocol RealmRepository {
    associatedtype Model
    associatedtype Entity
    
    func fetchAll() -> [Entity]
    func create(data: Model) throws
    func fetchItem(id: String) -> Model?
    func delete(id: String) throws
}
final class StarRatedRepository: RealmRepository {
    
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
    
    func fetchItem(id: String) -> StarRatedItemModel? {
        return realm.object(ofType: StarRatedItemModel.self, forPrimaryKey: id)
        
    }
    
    func getStarRate(id: String) -> Double {
//        if let item = fetchItem(id: id) {
//            return item.starRate
//        } else {
//            return 0
//        }
        
        return fetchItem(id: id)?.starRate ?? 0
    }
    
    func delete(id: String) throws {
        let item = fetchItem(id: id)
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
