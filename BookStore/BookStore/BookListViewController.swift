//
//  BookListViewController.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import UIKit

final class BookListViewController: UIViewController {
    
    // MARK: UIComponents
    
    private let listCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumLineSpacing = 20
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewFlowLayout
        )
        collectionView.backgroundColor = .white
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
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    // MARK: LifeCycles
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
    }
    
    deinit { debugPrint("\(self) deinit") }
    
}

// MARK: - Private functions

extension BookListViewController {
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
}


// MARK: - UICollectionViewDataSource

extension BookListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return .init()
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension BookListViewController: UICollectionViewDelegate {
    
}
