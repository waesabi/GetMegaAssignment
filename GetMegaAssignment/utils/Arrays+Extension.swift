//
//  Arrays+Extension.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import Foundation

public extension Array {
    
    subscript(safe index: Int) -> Element? {
        self.indices ~= index ? self[index] : nil
    }
    
}
