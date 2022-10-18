//
//  BookListCollectionViewCell.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import UIKit
import SnapKit

final class BookListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UIComponent
    
    private let bookNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let bookCategoryLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let bookPublishDateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let bookPriceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        let image = UIImage.init(systemName: "plus")?
            .withTintColor(
                .black,
                renderingMode: .alwaysOriginal
            )
        button.setImage(image, for: .normal)
        return button
    }()
    
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.configureLabels(
            self.bookNameLabel,
            self.bookCategoryLabel,
            self.bookPublishDateLabel,
            self.bookPriceLabel
        )
        self.setViewHierarchy()
        self.setViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.bookNameLabel.text = nil
        self.bookPriceLabel.text = nil
        self.bookCategoryLabel.text = nil
        self.bookPublishDateLabel.text = nil
    }
    
    // MARK: - Configure
    
    func configure(bookName: String, category: String, date: String, price: String) {
        self.bookNameLabel.text = bookName
        self.bookCategoryLabel.text = "\(category)"
        self.bookPublishDateLabel.text = "출판 일 : \(date)"
        self.bookPriceLabel.text = "가격 : \(price)"
    }

}

// MARK: - Private functions

extension BookListCollectionViewCell {
    private func configureLabels(_ labels: UILabel...) {
        labels.forEach { label in
            label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            label.textColor = .black
        }
    }
    
    private func setViewHierarchy() {
        self.addSubviews(
            self.bookNameLabel,
            self.bookCategoryLabel,
            self.bookPublishDateLabel,
            self.bookPriceLabel,
            self.deleteButton
        )
    }
    
    private func setViewConstraints() {
        self.deleteButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
        self.bookNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        self.bookCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(self.bookNameLabel.snp.top)
            make.leading.equalTo(self.bookNameLabel.snp.trailing).offset(10)
        }
        self.bookPublishDateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.bookNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.bookNameLabel.snp.leading)
            make.bottom.equalToSuperview().inset(20)
        }
        self.bookPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.bookPublishDateLabel.snp.top)
            make.leading.equalTo(self.bookPublishDateLabel.snp.trailing).offset(10)
            make.bottom.equalTo(self.bookPublishDateLabel.snp.bottom)
        }
    }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct BookListCollectionViewCellPresentable: UIViewRepresentable {
    typealias UIViewType = BookListCollectionViewCell
    
    func makeUIView(context: Context) -> BookListCollectionViewCell {
        BookListCollectionViewCell()
    }
    
    func updateUIView(_ uiView: BookListCollectionViewCell, context: Context) {
        uiView.configure(bookName: "해커스토익", category: "시집", date: "19.2.1", price: "100,002")
    }
}

struct BookListCollectionViewCellPreviews: PreviewProvider {
    static var previews: some View {
        BookListCollectionViewCellPresentable()
            .frame(width: 320, height: 74)
            .previewLayout(.sizeThatFits)
    }
}

#endif
