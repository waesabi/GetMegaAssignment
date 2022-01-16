//
//  Box.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import Foundation

class Box<T> {
    
    typealias Listener = (T) -> Void
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    var listener: ((T) -> Void)?
    
    init(_ v: T) {
        self.value = v
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
}
