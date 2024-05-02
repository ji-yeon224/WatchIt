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
    
    @Published var details: DetailMedia?
    @Published var castItems: [Cast] = []
    @Published var crewItems: [Cast] = []
    
    
    enum Action {
        case getDetailInfo(MediaType, Int)
        case getCreditInfo(MediaType, Int)
    }
    
    enum State {
        case detailInfo(DetailMedia?)
    }
    
    func action(_ action: Action) {
        switch action {
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
