//
//  MovieDetailViewModel.swift
//  WatchIt
//
//  Created by 김지연 on 4/16/24.
//

import Foundation
import Combine

final class MovieDetailViewModel: ViewModelProtocol {
    @Published var state: State
    
    private var cancellable: Set<AnyCancellable> = []
    
//    @Published var movieDetail: DetailMovie?
    @Published var castItems: [Cast] = []
    @Published var crewItems: [Cast] = []
    
    
    enum Action {
        case getDetailInfo(Int)
        case getCreditInfo(MediaType, Int)
    }
    
    enum State {
        case detailInfo(DetailMovie?)
    }
    
    init() {
        state = .detailInfo(nil)
    }
    
    func action(_ action: Action) {
        switch action {
        case .getDetailInfo(let id):
            getDetails(movieId: id)
        case .getCreditInfo(let type, let id):
            getCredits(type: type, id: id)
        }
    }
    
    
    private func getDetails(movieId: Int) {
        TMDBManager.shared.request(api: .movieDetail(movieId: movieId), resultType: MovieDetailResDto.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { result in
                self.state = .detailInfo(result.toDomain())
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
