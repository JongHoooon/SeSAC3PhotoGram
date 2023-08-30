//
//  SearchView.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

final class SearchView: BaseView {
    
    // MARK: - UI
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색어를 입력해주세요."
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero, 
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.register(
            SearchCollectionViewCell.self,
            forCellWithReuseIdentifier: "SearchCollectionViewCell"
        )
        return collectionView
    }()
    
    override func configureView() {
        [
            searchBar,
            collectionView
        ].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        collectionView.collectionViewLayout = collectionViewLayout()
    }
}

private extension SearchView {
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        let size = UIScreen.main.bounds.width - 40.0    // self.frame.width -> frame을 잡을 수 없다.
        layout.itemSize = CGSize(width: size / 4.0, height: size / 4.0)
        return layout
    }
}
