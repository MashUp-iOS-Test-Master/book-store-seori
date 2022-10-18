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
        self.numberFormatter.string(for: number)
    }
    
    func convert(decimalString: String) -> Int? {
        let numbers = decimalString.components(separatedBy: ",")
        let number = numbers.joined()
        return Int(number)
    }
   
}
