//
//  ViewModelProtocol.swift
//  WatchIt
//
//  Created by 김지연 on 4/20/24.
//

import SwiftUI

protocol ViewModelProtocol: ObservableObject {
    associatedtype Action
    associatedtype State
    
    var state: State { get }
    
    func action(_ action: Action)
}
