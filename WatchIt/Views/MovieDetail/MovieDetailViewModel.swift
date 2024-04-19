//
//  MovieDetailViewModel.swift
//  WatchIt
//
//  Created by 김지연 on 4/16/24.
//

import Foundation
import Combine

final class MovieDetailViewModel: ObservableObject {
    private var cancellable: Set<AnyCancellable> = []
    
    @Published var movieDetail: DetailMovie?
    @Published var castItems: [Cast] = []
    @Published var crewItems: [Cast] = []
    @Published var castCnt = 0
    @Published var crewCnt = 0
    
    func getDetails(movieId: Int) {
        TMDBManager.shared.request(api: .movieDetail(movieId: movieId), resultType: MovieDetailResDto.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { result in
                self.movieDetail = result.toDomain()
//                print(self.movieDetail)
            }
            .store(in: &cancellable)

    }
    
    func getCredits1(type: MediaType, id: Int) {
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
                self.castCnt = self.castItems.count
                self.crewItems = result.crew.map { $0.toDomain() }
                self.crewCnt = self.crewItems.count
                
            }
            .store(in: &cancellable)

    }
    
}
