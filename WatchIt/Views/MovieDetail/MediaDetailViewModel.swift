//
//  MovieDetailViewModel.swift
//  WatchIt
//
//  Created by 김지연 on 4/16/24.
//

import Foundation
import Combine

final class MediaDetailViewModel: ViewModelProtocol {
    
    private var cancellable: Set<AnyCancellable> = []
    private let starRatedRepository = StarRatedRepository()
    @Published var details: DetailMedia?
    @Published var castItems: [Cast] = []
    @Published var crewItems: [Cast] = []
    @Published var starValue: CGFloat = 0
    private var mediaType: MediaType = .movie
    private var fetchStarRate = PassthroughSubject<Int, Never>()
    
    enum Action {
        case setMediaType(MediaType)
        case getDetailInfo(MediaType, Int)
        case getCreditInfo(MediaType, Int)
    }
    
    func action(_ action: Action) {
        switch action {
        case .setMediaType(let type):
            mediaType = type
        case .getDetailInfo(let type, let id):
            switch type {
            case .movie:
                getDetails(type: type, id: id, responseType: MovieDetailResDto.self)
            case .tv:
                getDetails(type: type, id: id, responseType: TvDetailResDto.self)
            }
            
        case .getCreditInfo(let type, let id):
            getCredits(type: type, id: id)
       
            
        }
    }
    
    func bind() {
        $starValue
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .removeDuplicates()
            .sink { [weak self] value in
                self?.getSavedStarRateData(starRate: value)
                
            }
            .store(in: &cancellable)
        fetchStarRate
            .sink { id in
                self.starValue = self.starRatedRepository.getStarRate(id: self.mediaType.rawValue.getPrimaryKey(id: id))
            }
            .store(in: &cancellable)
    }
    
    
    
    
    
    
}

extension MediaDetailViewModel {
    
    private func getSavedStarRateData(starRate: Double) {
        if let details = details {
            let id = mediaType.rawValue.getPrimaryKey(id: details.id)
            
            if let item = starRatedRepository.fetchItem(id: id) { // update
                if starRate == 0 { //delete
                    deleteRateData(id: id)
                } else {
                    updateStarRate(item: item, starRate: starRate)
                }
                
            } else { // create
                if starRate != 0 {
                    let item = StarRatedItemModel(id: id, mediaId: details.id, title: details.title, posterPath: details.posterUrl, mediaType: mediaType.rawValue, starRate: starRate)
                    saveStarRate(item: item)
                }
                
            }
            
        }
    }
    
    private func saveStarRate(item: StarRatedItemModel) {
        do {
            try self.starRatedRepository.create(data: item)
        } catch {
            debugPrint(error.localizedDescription)
        }
        
    }
    
    private func updateStarRate(item: StarRatedItemModel, starRate: Double) {
        do {
            try self.starRatedRepository.updateRate(object: item, starRate: starRate)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func deleteRateData(id: String) {
        do {
            try starRatedRepository.delete(id: id)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}

extension MediaDetailViewModel {
    
    private func getDetails<T: ResponseProtocol>(type: MediaType, id: Int, responseType: T.Type) {
        TMDBManager.shared.request(api: .details(type: type, id: id), resultType: responseType)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { result in
                if let result = result as? DetailMedia {
                    self.details = result
                    self.fetchStarRate.send((result.id))
                }
            }
            .store(in: &cancellable)
    }
    
    
    
    private func getCredits(type: MediaType, id: Int) {
        TMDBManager.shared.request(api: .credits(type: type, id: id), resultType: CreditResDto.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { result in
                if let result = result as? CastList {
                    self.castItems = result.cast
                    self.crewItems = result.crew
                }
                
                
            }
            .store(in: &cancellable)

    }
}
