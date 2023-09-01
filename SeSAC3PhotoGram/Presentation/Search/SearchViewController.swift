//
//  SearchViewController.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit
import Kingfisher

final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    private var mainView = SearchView()
    private let imageList = [
        "pencil", "star", "person",
        "star.fill", "xmark", "person.circle"
    ]
    private var photoURLs: [String] = []
    var delegate: PassImageNameDelegate?
    
    deinit {
        print("deinit", self)
    }
    
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
        guard let query = searchBar.text else { return }
        
        APIService.shared.requstCall(
            of: PhotoURLPage.self,
            api: .searchPhoto(query: query),
            result: { [weak self] result in
                switch result {
                case let .success(value):
                    print(value)
                    if let urls = value.results?.compactMap({ $0.urls?.regular }) {
                        self?.photoURLs = urls
                        
                        DispatchQueue.main.async {
                            self?.mainView.collectionView.reloadData()
                        }
                    }
                    
                case let .failure(error):
                    print(error)
                }
            }
        )
        
        mainView.searchBar.text = ""
        mainView.searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return photoURLs.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SearchCollectionViewCell",
            for: indexPath
        ) as? SearchCollectionViewCell else { return UICollectionViewCell() }
                
        let item = photoURLs[indexPath.item]
        
        cell.imageView.kf.setImage(
            with: URL(string: item),
            placeholder: ImageSpace.imagePlaceholder
        )
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print(photoURLs[indexPath.item])
        
        NotificationCenter.default.post(
            name: .selectIamge,
            object: nil,
            userInfo: [
                "name": photoURLs[indexPath.item]
            ]
        )
        delegate?.receiveNmae(name: photoURLs[indexPath.item])
        
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
