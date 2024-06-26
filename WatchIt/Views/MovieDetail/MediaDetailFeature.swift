//
//  MediaDetailFeature.swift
//  WatchIt
//
//  Created by 김지연 on 5/8/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MediaDetailFeature {
    private let starRatedRepository = StarRatedRepository()
    private let wishItemRepository = WishItemRepository()
    
    @ObservableState
    struct State {
        var details: DetailMedia?
        var castItems: [Cast] = []
        var crewItems: [Cast] = []
        var starValue: CGFloat = 0
        var mediaType: MediaType = .movie
        var wishSaved: Bool = false
        var mediaId: String = ""
    }
    
    enum Action {
        case onAppear(type: MediaType, id: Int)
        case setStarValue(CGFloat)
        case fetchStarRate(Int)
        case getDetailInfo(MediaType, Int)
        case setDetailInfo(DetailMedia)
        case getCreditInfo(MediaType, Int)
        case setCastItems([Cast])
        case setCrewItems([Cast])
        case setWishSaved(Bool)
        case sucessedWishSaved(Bool)
        case getWishSavedInfo
    }
    
    enum ID: Hashable {
        case throttle
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .onAppear(type, id):
                state.mediaType = type
                state.mediaId = type.rawValue.getPrimaryKey(id: id)
                return .merge([
                    .send(.getDetailInfo(type, id)),
                    .send(.getCreditInfo(type, id)),
                    .send(.getWishSavedInfo)
                ])
            case let .setStarValue(value):
                if state.starValue != value {
                    state.starValue = value
                    return getSavedStarRateData(details: state.details, type: state.mediaType, starRate: value)
                        .throttle(id: ID.throttle, for: 1, scheduler: RunLoop.main, latest: true)
                }
                return .none
                
                
            case let .fetchStarRate(id):
                state.starValue = fetchStarRate(id: id, type: state.mediaType)
                return .none
            case let .getDetailInfo(type, id):
                switch type {
                case .movie:
                    return getDetails(type: type, id: id, responseType: MovieDetailResDto.self)
                case .tv:
                    return getDetails(type: type, id: id, responseType: TvDetailResDto.self)
                }
                
            case let .setDetailInfo(details):
                state.details = details
                return .none
            case let .getCreditInfo(type, id):
                return getCredits(type: type, id: id)
            case let .setCastItems(casts):
                state.castItems = casts
                return .none
            case let .setCrewItems(crews):
                state.crewItems = crews
                return .none
            case let .setWishSaved(saved):
                state.wishSaved = saved
                if let details = state.details {
                    if saved {
                        return saveWishItem(item: details.toWishRecord(type: state.mediaType))
                    } else {
                        return deleteWishItem(id: state.mediaId)
                    }
                }
                return .none
                
            case let .sucessedWishSaved(isSuccess):
                if !isSuccess {
                    state.wishSaved.toggle()
                }
                return .none
            case .getWishSavedInfo:
                if wishItemRepository.fetchItemById(id: state.mediaId) == nil {
                    state.wishSaved = false
                } else {
                    state.wishSaved = true
                }
                return .none
            }
        }
    }
}
extension MediaDetailFeature {
    
    private func saveWishItem(item: WishItemModel) -> Effect<Action>{
        if wishItemRepository.fetchItemById(id: item.id) == nil {
            do {
                try self.wishItemRepository.create(data: item)
                return .send(.sucessedWishSaved(true))
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        
        return .send(.sucessedWishSaved(false))
    }
    
    private func deleteWishItem(id: String) -> Effect<Action>{
        do {
            try wishItemRepository.delete(id: id)
            return .send(.sucessedWishSaved(true))
        } catch {
            debugPrint(error.localizedDescription)
        }
        return .send(.sucessedWishSaved(false))
        
    }
}
extension MediaDetailFeature {
    
    private func fetchStarRate(id: Int, type: MediaType) -> CGFloat {
        return starRatedRepository.getStarRate(id: type.rawValue.getPrimaryKey(id: id))
    }
    
    private func getSavedStarRateData(details: DetailMedia?, type: MediaType, starRate: Double) -> Effect<Action> {
        
        if let details = details {
            let id = type.rawValue.getPrimaryKey(id: details.id)
            
            if let item = starRatedRepository.fetchItemById(id: id) { // update
                if starRate == 0 { //delete
                    return deleteRateData(id: id)
                } else {
                    return updateStarRate(item: item, starRate: starRate)
                }
                
            } else { // create
                if starRate != 0 {
                    let item = StarRatedItemModel(id: id, mediaId: details.id, title: details.title, posterPath: details.posterUrl, mediaType: type.rawValue, starRate: starRate)
                    return saveStarRate(item: item)
                }
                
            }
            
        }
        return .none
    }
    
    private func saveStarRate(item: StarRatedItemModel) -> Effect<Action>{
        do {
            try self.starRatedRepository.create(data: item)
        } catch {
            debugPrint(error.localizedDescription)
        }
        return .none
    }
    
    private func updateStarRate(item: StarRatedItemModel, starRate: Double) -> Effect<Action> {
        do {
            try self.starRatedRepository.updateRate(object: item, starRate: starRate)
        } catch {
            debugPrint(error.localizedDescription)
        }
        return .none
    }
    
    private func deleteRateData(id: String) -> Effect<Action> {
        do {
            try starRatedRepository.delete(id: id)
        } catch {
            debugPrint(error.localizedDescription)
        }
        return .none
    }
}

extension MediaDetailFeature {
    private func getDetails<T: ResponseProtocol>(type: MediaType, id: Int, responseType: T.Type) -> Effect<Action> {
        
        return .run { send in
            let response = try await TMDBManager.shared.request(api: .details(type: type, id: id), resultType: responseType)
            if let response = response as? DetailMedia {
                await send(.setDetailInfo(response))
                await send(.fetchStarRate(response.id))
            }
        }
    }
    
    private func getCredits(type: MediaType, id: Int) -> Effect<Action> {
        return .run { send in
            let response = try await TMDBManager.shared.request(api: .credits(type: type, id: id), resultType: CreditResDto.self)
            if let response = response as? CastList {
                await send(.setCastItems(response.cast))
                await send(.setCrewItems(response.crew))
            }
        }
        
    }
}
