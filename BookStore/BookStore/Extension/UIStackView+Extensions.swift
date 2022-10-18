//
//  UIStackView+Extensions.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach(self.addArrangedSubview(_:))
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach(self.addArrangedSubview(_:))
    }
}
