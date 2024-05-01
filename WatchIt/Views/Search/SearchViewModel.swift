//
//  SearchViewModel.swift
//  WatchIt
//
//  Created by 김지연 on 5/1/24.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    
    private var cancellable: Set<AnyCancellable> = []
    @Published var searchAction = CurrentValueSubject<String, Never>("")
    @Published var curFilterType: MediaType = .movie
    @Published var mediaList: [MediaItem] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = "" 
    
    
    enum Action {
        case searchReqeust(type: MediaType)
        case resetResult
    }
    
    func action(_ action: Action) {
        switch action {
        case .searchReqeust(let type):
            isLoading = true
            print(curFilterType.rawValue, searchText)
            if type == .movie {
                searchMovieRequest(query: searchText)
            } else {
                searchTvRequest(query: searchText)
            }
        case .resetResult:
            self.mediaList = []
        }
    }
    
    func bind() {
        $curFilterType
            .removeDuplicates()
            .sink { type in
                self.action(.searchReqeust(type: type))
            }
            .store(in: &cancellable)
        searchAction
            .sink { value in
                if !value.isEmpty {
                    self.action(.searchReqeust(type: self.curFilterType))
                    
                }
            }
            .store(in: &cancellable)
        $searchText
            .removeDuplicates()
            .sink { value in
                if value.isEmpty {
                    self.mediaList.removeAll()
                }
            }
            .store(in: &cancellable)
    }
    
    
    private func searchMovieRequest(query: String) {
        TMDBManager.shared.request(api: .search(type: .movie, region: .kr, query: query), resultType: MovieListDto.self)
            .sink { completion in
//                debugPrint(completion)
                self.isLoading = false
            } receiveValue: { result in
                self.mediaList = result.results.map { $0.toDomain() }
            }
            .store(in: &cancellable)

    }
    private func searchTvRequest(query: String) {
        print("TV!!")
        TMDBManager.shared.request(api: .search(type: .tv, region: .kr, query: query), resultType: TvListDto.self)
            .sink { completion in
//                debugPrint(completion)
                self.isLoading = false
            } receiveValue: { result in
                self.mediaList.removeAll()
                self.mediaList = result.results.map { $0.toDomain() }
            }
            .store(in: &cancellable)

    }
}
