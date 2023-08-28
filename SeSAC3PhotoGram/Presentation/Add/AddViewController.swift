//
//  AddViewController.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

final class AddViewController: BaseViewController {

    private let mainView = AddView()
    
    // MARK: - Lifecycle
    override func loadView() { // viewDidLoad보다 먼저 호출된다. 🚨 super 메서드 호출 하면안됨!!
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(selectImageNotificationObserver),
            name: NSNotification.Name("SelectImage"),
            object: nil
        )
    }
    
    override func configureView() {
        super.configureView()
        print(#fileID, #function)
        
        mainView.searchButton.addTarget(
            self,
            action: #selector(searchButtonClicked),
            for: .touchUpInside
        )
    }
}
#warning("extension에서 override 불가능한 이유??")

// MARK: - Private
private extension AddViewController {
    
    @objc
    func selectImageNotificationObserver(notification: NSNotification) {
        print("select Image Notification Observer")
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc
    func searchButtonClicked() {
        
        let word = ["Apple", "Banna", "Cookie", "Cake", "Sky"]
        
        NotificationCenter.default.post(
            name: NSNotification.Name("RecommandKeyword"),
            object: nil,
            userInfo: [
                "word": word.randomElement()!
            ]
        )
        
        present(SearchViewController(), animated: true)
    }
}
