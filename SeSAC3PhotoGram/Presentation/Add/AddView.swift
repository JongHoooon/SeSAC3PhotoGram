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
    
    override func configureView() {
        [
            photoImageView,
            searchButton
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
    }
}
