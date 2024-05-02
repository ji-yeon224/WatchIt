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
            
            if type == .movie {
                searchRequest(query: searchText, type: type, resultType: MovieListResDto.self)
            } else {
                searchRequest(query: searchText, type: type, resultType: TvListResDto.self)
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
    
    private func searchRequest<T: ResponseProtocol>(query: String, type: MediaType, resultType: T.Type) {
        TMDBManager.shared.request(api: .search(type: type, region: .kr, query: query), resultType: resultType)
            .sink { completion in
                self.isLoading = false
            } receiveValue: { result in
                if let result = result as? MediaItemList {
                    self.mediaList = result.results
                }
            }
            .store(in: &cancellable)
    }
    
}
