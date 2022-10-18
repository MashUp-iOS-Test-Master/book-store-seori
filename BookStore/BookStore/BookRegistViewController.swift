//
//  BookRegistViewController.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import UIKit
import SnapKit

final class BookRegistViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private let bookNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "책 이름을 기입해주세요"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private let bookCategoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "책 카테고리를 선택해주세요"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private let bookPublishDateTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "책의 출판 일을 기입해주세요"
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private let bookPriceTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "책의 가격을 기입해주세요"
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private let registButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("등록하기", for: .normal)
        button.backgroundColor = .systemGroupedBackground
        button.layer.cornerRadius = 10
        return button
    }()
    
    private var contentTextFields: [UITextField] {
        return [self.bookNameTextField, self.bookCategoryTextField, self.bookPublishDateTextField, self.bookPriceTextField]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setViewHierarhcy()
        self.setViewsConstraints()
        self.configure(textFields: self.contentTextFields)
    }
    
    private func configure(textFields: [UITextField]) {
        textFields.forEach { textField in
            textField.addLeftPaddingView()
            textField.backgroundColor = .white
            textField.layer.cornerRadius = 10
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.borderWidth = 1
        }
    }
    
    private func setViewHierarhcy() {
        self.contentStackView.addArrangedSubviews(self.contentTextFields)
        self.view.addSubviews(self.contentStackView, self.registButton)
    }
    
    private func setViewsConstraints() {
        self.contentStackView.arrangedSubviews.forEach { view in
            view.snp.makeConstraints { $0.height.equalTo(50) }
        }
        self.contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.registButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Preview

#if DEBUG
import SwiftUI

struct BookRegistViewControllerPresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = BookRegistViewController
    
    func makeUIViewController(context: Context) -> BookRegistViewController {
        BookRegistViewController()
    }
    
    func updateUIViewController(
        _ uiViewController: BookRegistViewController,
        context: Context
    ) {
        
    }
}

struct BookRegistViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            BookRegistViewControllerPresentable()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//            BookRegistViewControllerPresentable()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
        }
        
    }
}

#endif
