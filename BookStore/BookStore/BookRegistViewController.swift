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
        return textField
    }()
    
    private let bookCategoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "책 카테고리를 선택해주세요"
        return textField
    }()
    
    private let bookPublishDateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "책의 출판 일을 기입해주세요"
        return textField
    }()
    
    private let bookPriceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "책의 가격을 기입해주세요"
        textField.keyboardType = .numberPad
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
    private let datePickerView = UIDatePicker()
    
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
    private let dateFormatter: BookStoreDateFormmater
    private let numberFormatter: BookStoreNumberFormatter
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setViewHierarhcy()
        self.setViewsConstraints()
        self.configure(textFields: self.contentTextFields)
        self.bind(self.registButton)
        self.configure(self.bookPublishDateTextField, inputView: self.datePickerView)
        self.configure(self.bookCategoryTextField, inputView: self.categoryPickerView)
        self.bookPriceTextField.delegate = self
        self.bind(self.view)
    }
   
    init(
        categories: [BookCategory] = BookCategory.allCases,
        dateFormatter: BookStoreDateFormmater = BookStoreDateFormmater(),
        numberFormatter: BookStoreNumberFormatter = BookStoreNumberFormatter()
    ) {
        self.categories = categories
        self.dateFormatter = dateFormatter
        self.numberFormatter = numberFormatter
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
    
    private func configure(_ dateTextField: UITextField, inputView: UIDatePicker) {
        dateTextField.inputView = inputView
        inputView.preferredDatePickerStyle = .wheels
        inputView.datePickerMode = .date
        inputView.addTarget(self, action: #selector(self.didEndEditing(datePicker:)), for: .allEvents)
    }
    
    @objc
    private func didEndEditing(datePicker: UIDatePicker) {
        let convertedDate = self.dateFormatter.convert(date: datePicker.date)
        self.bookPublishDateTextField.text = convertedDate
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
    
    private func bind(_ view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func didTapView() {
        self.view.endEditing(true)
    }
    
    @objc
    private func didTapRegistButton(_ sender: UIButton) {
        if self.canRegistBook() {
            self.dismiss(animated: true)
        } else {
            self.showAlert("빠진 내용들을 기입해주세요!")
        }
    }
    
    private func canRegistBook() -> Bool {
        let bookName = self.bookNameTextField.text ?? ""
        let category = self.bookCategoryTextField.text ?? ""
        let publishedDate = self.bookPublishDateTextField.text ?? ""
        let price = self.bookPriceTextField.text ?? ""
        if !bookName.isEmpty && !category.isEmpty && !publishedDate.isEmpty && !price.isEmpty {
            return true
        } else { return false }
    }
    
    private func showAlert(_ title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
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


extension BookRegistViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let number = Int(textField.text ?? "") ?? 0
        guard let decimalNumber = self.numberFormatter.convert(number: number) else { return }
        self.bookPriceTextField.text = decimalNumber
    }
}
