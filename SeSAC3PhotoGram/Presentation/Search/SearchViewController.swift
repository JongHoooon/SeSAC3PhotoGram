//
//  SearchViewController.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    private var mainView = SearchView()
    private let imageList = [
        "pencil", "star", "person",
        "star.fill", "xmark", "person.circle"
    ]
    var delegate: PassImageNameDelegate?
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.searchBar.becomeFirstResponder()
        mainView.searchBar.delegate = self
        
        // addObserver보다 post가 먼저 신호를 보내서 신호를 받을 수 없다.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(recommandKeywordNotificationOberver),
            name: NSNotification.Name("RecommandKeyword"),
            object: nil
        )
    }
    
    override func configureView() {
        super.configureView()
        configureCollectionView()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return imageList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SearchCollectionViewCell",
            for: indexPath
        ) as? SearchCollectionViewCell else { return UICollectionViewCell() }
                
        let item = imageList[indexPath.item]
        
        cell.imageView.image = UIImage(systemName: item)
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print(imageList[indexPath.item])
        
        NotificationCenter.default.post(
            name: .selectIamge,
            object: nil,
            userInfo: [
                "name": imageList[indexPath.item]
            ]
        )
        delegate?.receiveNmae(name: imageList[indexPath.item])
        
        dismiss(animated: true)
    }
}

private extension SearchViewController {
    
    func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    @objc
    func recommandKeywordNotificationOberver(notification: NSNotification) {
        print(#fileID, #function)
        // 전달되지 않음!
    }
}
