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
                print(self.movieDetail)
            }
            .store(in: &cancellable)

    }
}
