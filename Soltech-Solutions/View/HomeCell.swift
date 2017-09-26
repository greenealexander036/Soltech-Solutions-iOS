//
//  HomeCell.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/24/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class HomeCell: UICollectionViewCell {
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        constrain(imageView, label) { (imageView, label) in
            imageView.top == imageView.superview!.top
            imageView.left == imageView.superview!.left
            imageView.bottom == imageView.superview!.bottom
            imageView.right == imageView.superview!.right
            
            label.top == imageView.superview!.top
            label.left == imageView.superview!.left
            label.bottom == imageView.superview!.bottom
            label.right == imageView.superview!.right
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(title: String, imageName: String) {
        label.text = title
        imageView.image = UIImage(named: "orange")
    }
}
















