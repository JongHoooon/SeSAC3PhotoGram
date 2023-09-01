//
//  HomeViewController.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/31.
//

import UIKit

#warning("NSObject vs AnyObject, class")
// AnyObject: 클래스에서만 프로토콜을 정의할 수 있도로 제약
protocol HomeViewProtocol: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}

final class HomeViewController: BaseViewController {
    
    override func loadView() {
        let view = HomeView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
    }
    
    deinit {
        print(self, #function)
    }
}

extension HomeViewController: HomeViewProtocol {
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }
}
