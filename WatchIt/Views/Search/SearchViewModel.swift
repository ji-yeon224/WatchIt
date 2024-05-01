//
//  SearchViewModel.swift
//  WatchIt
//
//  Created by 김지연 on 5/1/24.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    
    @Published var mediaList: [MediaItem] = []
    @Published var isLoading: Bool = false
    private var cancellable: Set<AnyCancellable> = []
    
    enum Action {
        case searchReqeust(type: MediaType, query: String)
    }
    
    func action(_ action: Action) {
        switch action {
        case .searchReqeust(let type, let query):
            isLoading = true
            if type == .movie {
                searchMovieRequest(query: query)
            }
        }
    }
    
    private func searchMovieRequest(query: String) {
        TMDBManager.shared.request(api: .search(type: .movie, region: .kr, query: query), resultType: MovieListDto.self)
            .sink { completion in
                debugPrint(completion)
                self.isLoading = false
            } receiveValue: { result in
                self.mediaList = result.results.map { $0.toDomain() }
                print(self.mediaList)
            }
            .store(in: &cancellable)

    }
}
