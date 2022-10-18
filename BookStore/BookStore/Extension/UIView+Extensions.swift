//
//  UIView+Extensions.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach(self.addSubview(_:))
    }
}
