//
//  BookCategory.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import Foundation

enum BookCategory: CaseIterable {
    case novel
    case poetry
    case tech
    case economy
    
    var title: String {
        switch self {
        case .novel: return "소설"
        case .poetry: return "시집"
        case .tech: return "기술"
        case .economy: return "경제"
        }
    }
}
