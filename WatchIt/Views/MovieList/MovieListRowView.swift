//
//  MovieListRowView.swift
//  WatchIt
//
//  Created by 김지연 on 4/20/24.
//

import SwiftUI

struct MovieListRowView: View {
    
    var title: String = "Trend"
    var itemList: [MovieItem] = []
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .font(Constants.FontStyle.title.style)
                
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top) {
                    ForEach(itemList) { item in
                        NavigationLink(value: item) {
                            MovieItemView(movie: item)
                        }
                        .buttonStyle(.plain)
                        
                    }
                }
                
            }
        }
        
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
    }
}
