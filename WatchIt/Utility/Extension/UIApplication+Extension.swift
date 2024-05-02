//
//  UIApplication+Extension.swift
//  WatchIt
//
//  Created by 김지연 on 4/29/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
