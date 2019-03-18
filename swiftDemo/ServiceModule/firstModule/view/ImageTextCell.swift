//
//  ImageTextCell.swift
//  swiftDemo
//
//  Created by yinghu on 2019/3/18.
//  Copyright © 2019 yinghu. All rights reserved.
//

import UIKit

struct ImageTextCellItem {
    let imageName: String
    let text: String
}

class ImageTextCell: UITableViewCell {
    private lazy var firstImageView: UIImageView = {
        let imageView = UIHelper.generateImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        return contentLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(firstImageView)
        firstImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        firstImageView.widthAnchor.constraint(equalTo: firstImageView.heightAnchor).isActive = true
        firstImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        firstImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        contentView.addSubview(contentLabel)
        contentLabel.leadingAnchor.constraint(equalTo: firstImageView.trailingAnchor, constant: 15).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        contentLabel.widthAnchor.constraint(equalTo: firstImageView.widthAnchor, multiplier: 3).isActive = true
        contentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageTextCell: Updatable {
    func update(viewData: ImageTextCellItem) {
        firstImageView.image = UIImage(named: viewData.imageName)
        contentLabel.text = viewData.text
    }
}

