//
//  String+Extenstion.swift
//  WatchIt
//
//  Created by 김지연 on 4/15/24.
//

import Foundation
extension String {
    var releaseYear: String? {
        return self.components(separatedBy: "-").first
    }
    
    func getPrimaryKey(id: Int) -> String {
        return "\(id)_\(self)"
    }
    
}
