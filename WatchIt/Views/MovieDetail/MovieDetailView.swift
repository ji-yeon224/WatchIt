//
//  MovieDetailView.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    private var poster: String = BaseURL.imgURL+"/8uUU2pxm6IYZw8UgnKJyx7Dqwu9.jpg"
    private var backdrop: String = BaseURL.imgURL+"/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg"
    
    var body: some View {
        VStack(alignment: .leading) {
            MovieInfoView()
            Spacer()
        }
    }
}

#Preview {
    MovieDetailView()
}
