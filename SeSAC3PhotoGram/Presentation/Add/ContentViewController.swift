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
    
    let sampleView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    let greenView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    // Closure - 1
    var completionHandler: ((String) -> Void)?
    
    deinit {
        print("deinit", self)
    }
    
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
        view.addSubview(sampleView)
        view.addSubview(greenView)
        setAnimation()
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10.0)
            $0.height.equalTo(250.0)
        }
        
        sampleView.snp.makeConstraints {
            $0.size.equalTo(100.0)
            $0.center.equalTo(view)
        }
        
        greenView.snp.makeConstraints {
            $0.size.equalTo(100.0)
            $0.center.equalTo(view).offset(80.0)
        }
    }
    
    func setAnimation() {
        // 시작
        sampleView.alpha = 0.0
        greenView.alpha = 0.0
        // 끝
        UIView.animate(
            withDuration: 1.0,
            delay: 2.0,
            options: [.curveLinear],
            animations: { [weak self] in
                self?.sampleView.alpha = 1.0
                self?.sampleView.backgroundColor = .blue
            },
            completion: { [weak self] bool in
                
                UIView.animate(withDuration: 1.0, animations: {
                    self?.greenView.alpha = 1.0
                })
                
            }
        )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async { [weak self] in
            self?.greenView.alpha = 1.0
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    self?.greenView.alpha = 0.5
                }
            )
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async { [weak self] in
            self?.greenView.alpha = 0.5
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    self?.greenView.alpha = 1.0
            })
        }
    }
}
