//
//  ContentViewController.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/29.
//

import UIKit

final class ContentViewController: BaseViewController {
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.placeholder = "제목을 입력해주세요."
        return textField
    }()
    
    // Closure - 1
    var completionHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Closure - 2
        completionHandler?(textField.text ?? "")
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10.0)
            $0.height.equalTo(250.0)
        }
    }
}
