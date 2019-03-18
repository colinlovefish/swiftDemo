//
//  UIHelper.swift
//  swiftDemo
//
//  Created by yinghu on 2019/3/18.
//  Copyright © 2019 yinghu. All rights reserved.
//

import UIKit
//
//class UIHelper: NSObject {
//
//}

struct UIHelper {
    static func generateImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        imageView.layer.cornerRadius = 3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func generateTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
        
    }
}
