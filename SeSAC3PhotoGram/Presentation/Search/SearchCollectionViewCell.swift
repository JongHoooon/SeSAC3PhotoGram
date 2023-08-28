//
//  SearchCollectionViewCell.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

final class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func configureView() {
        contentView.addSubview(imageView)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
}
