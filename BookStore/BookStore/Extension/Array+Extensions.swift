//
//  Array+Extensions.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Array.Element? {
        if indices ~= index {
            return self[index]
        } else { return nil }
    }
}
