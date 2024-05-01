//
//  Date+Extension.swift
//  WatchIt
//
//  Created by 김지연 on 4/22/24.
//

import Foundation
extension Date {
    var getYearToStr: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let convertDate = dateFormatter.string(from: self)
        return convertDate
    }
}
