//
//  TitleViewController.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/29.
//

import UIKit

final class TitleViewController: BaseViewController {
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력해주세요."
        return textField
    }()
    
    
    
    // Closure - 1
    var completionHandler: ((String, Int, Bool) -> Void)?
    
    deinit {
        print("deinit", self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Closure - 2
        completionHandler?(textField.text ?? "", 100, true)
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(doneButtonClicked)
        )
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10.0)
            $0.height.equalTo(50.0)
        }
    }
    
    @objc
    func doneButtonClicked() {
        completionHandler?(textField.text ?? "", 100, true)
        navigationController?.popViewController(animated: true)
    }
}

