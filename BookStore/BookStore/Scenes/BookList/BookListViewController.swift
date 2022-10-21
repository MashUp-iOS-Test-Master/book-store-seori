//
//  BookListViewController.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import UIKit
import SnapKit
import CoreData

final class BookListViewController: UIViewController {
    
    typealias BookListCollectionViewCellItem = BookListCollectionViewCell.Item
    
    // MARK: - UIComponents
    
    private let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let navigationTitle: UILabel = {
        let label = UILabel()
        label.text = "책 목록"
        return label
    }()
    
    private let registButton: UIButton = {
        let button = UIButton()
        let image = UIImage.init(systemName: "plus")?
            .withTintColor(
                .black,
                renderingMode: .alwaysOriginal
            )
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let listCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumLineSpacing = 20
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewFlowLayout
        )
        collectionView.backgroundColor = .systemGroupedBackground
        return collectionView
    }()
    
    private let totalPriceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    
    // MARK: - Properties
    
    private var bookModels: [Book] {
        didSet {
            self.listCollectionView.reloadData()
            let prices = self.bookModels.compactMap(\.price)
            self.updateTotalPrice(prices)
        }
    }
    private let numberFormatter: BookStoreNumberFormatter
    private let persistentContainer: PersistentContainerable
    
    // MARK: - LifeCycles
    
    init(
        numberFormatter: BookStoreNumberFormatter = BookStoreNumberFormatter(),
        persistentContainer: PersistentContainerable
    ) {
        self.persistentContainer = persistentContainer
        self.numberFormatter = numberFormatter
        self.bookModels = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGroupedBackground
        self.navigationController?.navigationBar.isHidden = true
        self.setViewHierarchy()
        self.setViewConstraints()
        self.registerCells(BookListCollectionViewCell.self, at: self.listCollectionView)
        self.configure(self.listCollectionView)
        self.bind(registButton: self.registButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchBookModels()
    }
    
    deinit { debugPrint("\(self) deinit") }
    
}

// MARK: - Private functions

extension BookListViewController {
    
    private func fetchBookModels() {
        let context = self.persistentContainer.context
        let bookModels = try? context.fetch(Book.fetchRequest()) as? [Book]
        self.bookModels = bookModels ?? []
    }

    private func updateTotalPrice(_ prices: [String]) {
        let priceInt = prices.compactMap(self.numberFormatter.convert(decimalString:))
        let totalPrice = priceInt.reduce(0) { $0 + $1 }
        guard let totalPriceDeimalString = self.numberFormatter.convert(number: totalPrice) else { return }
        self.totalPriceLabel.text = "총 가격 : \(totalPriceDeimalString) 원"
    }
    
    private func bind(registButton: UIButton) {
        registButton.addTarget(self, action: #selector(self.didTapRegistButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func didTapRegistButton(_ sender: UIButton) {
        let registViewController = BookRegistViewController()
        self.navigationController?.pushViewController(registViewController, animated: true)
    }
    
    private func configure(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerCells(
        _ cellType: UICollectionViewCell.Type,
        at collectionView: UICollectionView
    ) {
        collectionView.register(
            cellType,
            forCellWithReuseIdentifier: String(describing: cellType.self)
        )
    }
    
    private func setViewHierarchy() {
        self.totalPriceView.addSubviews(self.totalPriceLabel)
        self.navigationView.addSubviews(self.navigationTitle, self.registButton)
        self.view.addSubviews(self.listCollectionView, self.totalPriceView, self.navigationView)
    }
    
    private func setViewConstraints() {
        self.navigationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        self.listCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        self.totalPriceView.snp.makeConstraints { make in
            make.top.equalTo(self.listCollectionView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(80)
        }

        self.totalPriceLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.navigationTitle.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        self.registButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.navigationTitle.snp.centerY)
            make.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func configureBookItem(_ bookModel: Book) -> BookListCollectionViewCellItem? {
        guard let name = bookModel.name,
              let category = bookModel.category,
              let publishedDate = bookModel.publishedDate,
              let price = bookModel.price else { return nil }
        return BookListCollectionViewCellItem(
            name: name,
            category: category,
            publishedDate: publishedDate,
            price: price
        )
    }
    
    private func didTapDeleteButton(at indexPath: IndexPath) {
        guard let book = self.bookModels[safe: indexPath.item] else { return }
        do {
            self.persistentContainer.context.delete(book)
            try self.persistentContainer.context.save()
            print("성공~")
            self.bookModels.remove(at: indexPath.item)
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
}


// MARK: - UICollectionViewDataSource

extension BookListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        self.bookModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: BookListCollectionViewCell.self),
            for: indexPath
        ) as? BookListCollectionViewCell else { return .init() }
        
        guard let book = self.bookModels[safe: indexPath.item],
              let cellItem = self.configureBookItem(book) else { return .init() }
    
        cell.configure(
            item: cellItem,
            didTapDeleteButton: { [weak self] in
                self?.didTapDeleteButton(at: indexPath)
            }
        )
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension BookListViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BookListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 74)
    }
}


// MARK: - Preview

#if DEBUG
import SwiftUI

struct BookListViewControllerPresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = BookListViewController
    
    final class MockPersistentContainer: PersistentContainerable {
        var context: ManagedObjectContextable { self.viewContext }
        var viewContext: NSManagedObjectContext = .init(.mainQueue)
    }
    
    func makeUIViewController(context: Context) -> BookListViewController {
        BookListViewController(persistentContainer: MockPersistentContainer())
    }
    
    func updateUIViewController(
        _ uiViewController: BookListViewController,
        context: Context
    ) {
        
    }
}

struct BookListViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            BookListViewControllerPresentable()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            BookListViewControllerPresentable()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
        }
       
    }
}

#endif
