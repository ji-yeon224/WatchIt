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
    
//    @Published var movieDetail: DetailMovie?
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
                getMovieDetails(type: type, id: id)
            case .tv:
                getTvDetails(type: type, id: id)
            }
            
        case .getCreditInfo(let type, let id):
            getCredits(type: type, id: id)
        }
    }
    
    
    private func getMovieDetails(type: MediaType, id: Int) {
        TMDBManager.shared.request(api: .details(type: type, id: id), resultType: MovieDetailResDto.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { result in
                self.details = result.toDomain()
            }
            .store(in: &cancellable)

    }
    
    private func getTvDetails(type: MediaType, id: Int) {
        TMDBManager.shared.request(api: .details(type: type, id: id), resultType: TvDetailResDto.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { result in
                self.details = result.toDomain()
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
                self.castItems = result.cast.map { $0.toDomain() }
                self.crewItems = result.crew.map { $0.toDomain() }
                
            }
            .store(in: &cancellable)

    }
    
}
