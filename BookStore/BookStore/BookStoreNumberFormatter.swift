//
//  BookStoreNumberFormatter.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import Foundation

struct BookStoreNumberFormatter {
    private let numberFormatter: NumberFormatter
    
    init(
        numberStyle: NumberFormatter.Style = .decimal
    ) {
        self.numberFormatter = NumberFormatter()
        self.numberFormatter.numberStyle = numberStyle
    }
    
    func convert(number: Int) -> String? {
        self.numberFormatter.string(from: NSNumber(value: number))
    }
}
