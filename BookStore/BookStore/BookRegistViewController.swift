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
    
    private let categoryPickerView = UIPickerView()
    
    // MARK: - Properties
    
    private var contentTextFields: [UITextField] {
        return [
            self.bookNameTextField,
            self.bookCategoryTextField,
            self.bookPublishDateTextField,
            self.bookPriceTextField
        ]
    }
    private let categories: [BookCategory]
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setViewHierarhcy()
        self.setViewsConstraints()
        self.configure(textFields: self.contentTextFields)
        self.bind(self.registButton)
        self.configure(self.bookCategoryTextField, inputView: self.categoryPickerView)
    }
   
    init(
        categories: [BookCategory] = BookCategory.allCases
    ) {
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { debugPrint("\(self) deinit") }
}

// MARK: - Private functions

extension BookRegistViewController {
    
    private func configure(textFields: [UITextField]) {
        textFields.forEach { textField in
            textField.addLeftPaddingView()
            textField.backgroundColor = .white
            textField.layer.cornerRadius = 10
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.borderWidth = 1
        }
    }
    
    private func configure(_ categoryTextField: UITextField, inputView: UIPickerView) {
        categoryTextField.inputView = inputView
        inputView.dataSource = self
        inputView.delegate = self
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
    
    private func bind(_ registButton: UIButton) {
        registButton.addTarget(self, action: #selector(didTapRegistButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func didTapRegistButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    private func didSelectCategory(at index: Int) {
        guard let selectedCategory = self.categories[safe: index] else { return }
        self.bookCategoryTextField.text = selectedCategory.title
    }
}

// MARK: - UIPickerViewDataSource

extension BookRegistViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        self.categories.count
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        self.categories[safe: row]?.title
    }
    
}

// MARK: - UIPickerViewDelegate

extension BookRegistViewController: UIPickerViewDelegate {
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        self.didSelectCategory(at: row)
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
