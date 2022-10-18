//
//  BookStoreDateFormmater.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import Foundation

struct BookStoreDateFormmater {
    private let dateFormatter: DateFormatter
    
    init(dateFormat: String = "yyyy.MM.dd") {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = dateFormat
    }
    
    func convert(date: Date) -> String {
        self.dateFormatter.string(from: date)
    }
}
