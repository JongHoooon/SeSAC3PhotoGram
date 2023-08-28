//
//  BaseViewController.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

import SnapKit

class BaseViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: - Base Configuration
    func configureView() {
        print(#fileID, #function)
        view.backgroundColor = .systemBackground
    }
}
