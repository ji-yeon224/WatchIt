//
//  SearchItemView.swift
//  WatchIt
//
//  Created by 김지연 on 5/1/24.
//

import SwiftUI

struct SearchItemView: View {
    var media: MediaItem?
    var body: some View {
        if let media = media {
            HStack(alignment: .center, spacing: 18) {
                PosterImage(url: media.posterUrl, width: 50, height: 75)
                
                Text(media.title)
                    .font(Constants.FontStyle.boldPlain.style)
            }
        }
        
    }
}

#Preview {
    SearchItemView()
}
