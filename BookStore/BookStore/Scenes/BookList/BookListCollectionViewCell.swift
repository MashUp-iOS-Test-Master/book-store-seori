//
//  BookListCollectionViewCell.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import UIKit
import SnapKit

protocol BookListCollectionViewCellDelegate: AnyObject {
    func bookListCollectionViewCell(_ cell: UICollectionViewCell, didTapDeleteButton: UIButton)
}

final class BookListCollectionViewCell: UICollectionViewCell {
    
   
    
    struct Item {
        let name: String
        let category: String
        let publishedDate: String
        let price: String
    }
    
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
        let image = UIImage.init(systemName: "trash")?
            .withTintColor(
                .black,
                renderingMode: .alwaysOriginal
            )
        button.setImage(image, for: .normal)
        return button
    }()
    
    // MARK: - Properties
    weak var delegate: BookListCollectionViewCellDelegate?
    private var didTapDeleteButton: (() -> Void)?
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.configureLabels(
            self.bookNameLabel,
            self.bookCategoryLabel,
            self.bookPublishDateLabel,
            self.bookPriceLabel
        )
        self.backgroundColor = .white
        self.setViewHierarchy()
        self.setViewConstraints()
        self.bind(self.deleteButton)
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
        self.didTapDeleteButton = nil
        self.delegate = nil
    }
    
    // MARK: - Configure
    
    // button touch이벤트를 viewcontroller에게 알려줄 때
    // 1. delegate 패턴 사용
    // 2. configure할 때 클로저같은걸 같이 주입받는다
    // 3. button을 internal하게 열어서 다른 곳에서 액션처리도 다 해줌
    
    // 1번을 선택하기로했다. 왜냐하면 2번을 한다는건 configure함수를 cellForItemAt에서 부를텐데, 그럼 touch이벤트에대한 무언가 액션은 viewcontroller에서(혹은 datasource를 채택한 객체) 한다는게 고정이되어버리기때문
    // 그래서 delegate패턴을 사용하게되면 나는 버튼 눌렸어~ 이 액션은 다른 객체에게 위임할게. delegate를 채택하는 객체가 위임하도록하자! 좀 더 자유성을 준다고 생각했다. 굳이 datasource를 채택한 객체에서 액션을 넣어주지않아도되기때문.
    // 그러나 주의점은 cell이 재사용될 때 마다 delegate 변수에 nil할당은 필요할 것 같음. delegate를 위임한 객체가 여러개가 생기지않도록하기위해서!
    // 그러나 또 단점은 delegate 를 설정해주지않으면 아무 일도 일어나지않는다는 것이고, 이를 강제할 방법에 대해 고민할 필용는 있을 것 같음. configure에 같이 넣게되면 클로저를 파라미터에 꼭 넣어야하니까 강제성은 부여되어서, 컴파일타임에 실수할 확률은 줄어들게될 것 같다. (cell init시에 delegate를 주입받게하고싶지만, collectionview 내부 로직에 따라 designated init함수를 만들 수는 없을 것 같음.. ㅇㅅㅇ
    
    // 아니다 configure할 때 액션도 주입받는게 좋을거같기도하고..?
    
    func configure(
        item: Item,
        didTapDeleteButton: @escaping (() -> Void)
    ) {
        self.bookNameLabel.text = item.name
        self.bookCategoryLabel.text = "\(item.category)"
        self.bookPublishDateLabel.text = "출판 일 : \(item.publishedDate)"
        self.bookPriceLabel.text = "가격 : \(item.price)"
        self.didTapDeleteButton = didTapDeleteButton
    }

}

// MARK: - Private functions

extension BookListCollectionViewCell {
    
    private func bind(_ deleteButton: UIButton) {
        deleteButton.addTarget(self, action: #selector(self.didTapDeleteButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func didTapDeleteButton(_ sender: UIButton) {
        // 어떤 방법이 더 좋을지 모르겠움 ㅜㅜ
        self.didTapDeleteButton?()  // 1
        self.delegate?.bookListCollectionViewCell(self, didTapDeleteButton: sender)    // 2
    }
    
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
        uiView.configure(item: .init(name: "해커스토익", category: "영어", publishedDate: "2020.01.10", price: "10")) {
            
        }
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
