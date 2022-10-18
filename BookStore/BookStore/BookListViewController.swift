//
//  BookListViewController.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import UIKit
import SnapKit

final class BookListViewController: UIViewController {
    
    // MARK: UIComponents
    
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
        label.text = "가격합계 : "
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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
        self.view.backgroundColor = .systemGroupedBackground
        self.setViewHierarchy()
        self.setViewConstraints()
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
    
    private func setViewHierarchy() {
        self.totalPriceView.addSubviews(self.totalPriceLabel)
        self.navigationView.addSubviews(self.navigationTitle, self.registButton)
        self.view.addSubviews(self.listCollectionView, self.totalPriceView, self.navigationView)
    }
    
    private func setViewConstraints() {
        self.navigationView.snp.makeConstraints { make in
            make.top.equalTo(self.view.layoutMarginsGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
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
            make.center.equalToSuperview()
        }
        self.registButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(30)
        }
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
