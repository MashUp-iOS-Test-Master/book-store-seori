//
//  UITextField+Extensions.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import Foundation
import UIKit

extension UITextField {
    private func createPaddingView(_ width: CGFloat) -> UIView {
        UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
    }
    
    func addLeftPaddingView(
        _ width: CGFloat = 10,
        at leftViewMode: UITextField.ViewMode = .always
    ) {
        self.leftView = self.createPaddingView(width)
        self.leftViewMode = leftViewMode
    }
}
