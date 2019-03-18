//
//  TwoImageCell.swift
//  swiftDemo
//
//  Created by yinghu on 2019/3/18.
//  Copyright © 2019 yinghu. All rights reserved.
//

import UIKit

class TwoImageCell: UITableViewCell,Updatable {
   
    
    private lazy var firstImageView: UIImageView = {
        let imageView = UIHelper.generateImageView()
        imageView.backgroundColor = UIColor(hex: 0x4169E1)
        return imageView
    }()
    
    private lazy var secondImageView: UIImageView = {
        let imageView = UIHelper.generateImageView()
        imageView.backgroundColor = UIColor(hex: 0x6495ED)
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let titleLabel = UIHelper.generateTitleLabel()
        titleLabel.text = "\(classForCoder)"
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        
        contentView.addSubview(firstImageView)
        firstImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        firstImageView.widthAnchor.constraint(equalTo: firstImageView.heightAnchor).isActive = true
        firstImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        firstImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        contentView.addSubview(secondImageView)
        secondImageView.leadingAnchor.constraint(equalTo: firstImageView.trailingAnchor, constant: 15).isActive = true
        secondImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        secondImageView.centerYAnchor.constraint(equalTo: firstImageView.centerYAnchor).isActive = true
        secondImageView.heightAnchor.constraint(equalTo: firstImageView.heightAnchor).isActive = true
        secondImageView.widthAnchor.constraint(equalTo: firstImageView.widthAnchor, multiplier: 2).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


