//
//  MovieListRowView.swift
//  WatchIt
//
//  Created by 김지연 on 4/20/24.
//

import SwiftUI

struct MediaListRowView: View {
    
    var title: String = "Trend"
    var itemList: [MediaItem] = []
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .font(Constants.FontStyle.title2.style)
                
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(itemList) { item in
                        NavigationLink(value: item) {
                            MediaItemView(item: item)
                        }
                        .buttonStyle(.plain)
                        
                    }
                }
                
            }
            
        }
        
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
    }
}

#Preview {
    MediaListRowView(title: "Trend", itemList: [
        MediaItem(id: 1, title: "가나다라마바사아자파카ㅏ-- 하", posterUrl: nil, starRate: 0.0),
        MediaItem(id: 2, title: "가나다라마바사아자파카ㅏ-- 하", posterUrl: nil, starRate: 0.0),
        MediaItem(id: 3, title: "가나다라마바사아자파카ㅏ-- 하", posterUrl: nil, starRate: 0.0)
    ])
}
