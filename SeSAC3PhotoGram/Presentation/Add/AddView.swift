//
//  AddView.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

final class AddView: BaseView {
    
    // MARK: - UI
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        return button
    }()
    
    let searchProtocolButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBrown
        return button
    }()
    
    let dateButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle(DateFormatter.today(), for: .normal)
        return button
    }()
    
    let titleButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("오늘의 사진", for: .normal)
        return button
    }()
    
    let closureButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("클로저 버튼", for: .normal)
        return button
    }()
    
    let contentButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("콘텐트 버튼", for: .normal)
        return button
    }()
    
    override func configureView() {
        [
            photoImageView,
            searchButton,
            searchProtocolButton,
            dateButton,
            titleButton,
            closureButton,
            contentButton
        ].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints {
            $0.topMargin.leadingMargin.trailingMargin.equalTo(safeAreaLayoutGuide).inset(10.0)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        
        searchButton.snp.makeConstraints {
            $0.size.equalTo(50.0)
            $0.bottom.trailing.equalTo(photoImageView)
        }
        
        searchProtocolButton.snp.makeConstraints {
            $0.size.equalTo(50.0)
            $0.bottom.leading.equalTo(photoImageView)
        }
        
        dateButton.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom).offset(10.0)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(50.0)
        }
        
        titleButton.snp.makeConstraints {
            $0.top.equalTo(dateButton.snp.bottom).offset(10.0)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(50.0)
        }
            
        closureButton.snp.makeConstraints {
            $0.top.equalTo(titleButton.snp.bottom).offset(10.0)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(50.0)
        }
        
        contentButton.snp.makeConstraints {
            $0.top.equalTo(closureButton.snp.bottom).offset(10.0)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(150.0)
        }
    }
}
