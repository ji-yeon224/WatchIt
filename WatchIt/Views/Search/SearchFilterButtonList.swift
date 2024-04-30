//
//  SearchFilterButtonList.swift
//  WatchIt
//
//  Created by 김지연 on 4/30/24.
//

import SwiftUI

struct SearchFilterButtonList: View {
    @Binding var curFilter: MediaType
    
    private let filterList = MediaType.allCases
    var body: some View {
        HStack {
            ForEach(filterList, id: \.self) { item in
                SearchFilterButton(buttonType: item, curFilter: $curFilter)
            }
        }
    }
}

#Preview {
    SearchFilterButtonList(curFilter: .constant(.movie))
}
