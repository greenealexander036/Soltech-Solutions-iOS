//
//  PlantCell.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/25/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class PlantCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        constrain(imageView, label) { (img, label) in
            img.top == img.superview!.top
            img.right == img.superview!.right
            img.left == img.superview!.left
            img.bottom == label.top
            
            label.bottom == img.superview!.bottom
            label.right == img.superview!.right
            label.left == img.superview!.left
            label.height == 40
        }
    }
    
    func configureCell(imageName: String, labelText: String) {
        label.text = labelText
        imageView.image = UIImage(named: imageName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
