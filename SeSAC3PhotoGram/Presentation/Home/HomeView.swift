//
//  HomeView.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/31.
//

import UIKit

import SnapKit

final class HomeView: BaseView {
    
    weak var delegate: HomeViewProtocol?
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout()
        )
        collectionView.register(
            SearchCollectionViewCell.self,
            forCellWithReuseIdentifier: "SearchCollectionViewCell"
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    deinit {
        print("deinit", self)
    }
    
    override func configureView() {
        super.configureView()
        
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
        let size = UIScreen.main.bounds.width - 40.0    // self.frame.width -> frame을 잡을 수 없다.
        layout.itemSize = CGSize(width: size / 3, height: size / 3)
        return layout
    }
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        100
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SearchCollectionViewCell",
            for: indexPath
        ) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.backgroundColor = .systemBlue
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print(#function)
        delegate?.didSelectItemAt(indexPath: indexPath)
    }
}

extension HomeView: UICollectionViewDelegate {
    
}
