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
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
		label.backgroundColor = COLOR_NAV_TINT
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize(width: 1, height: 2)
		layer.shadowRadius = 5
		layer.shadowOpacity = 0.1
		backgroundColor = .white
		contentView.clipsToBounds = true
		contentView.layer.cornerRadius = 5
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
            label.height == 50
        }
    }
    
    func configureCell(imageData: Data, labelText: String) {
        label.text = labelText
        imageView.image = UIImage(data: imageData)
    }

	func highlightCell() {
		UIView.animate(withDuration: 0.25) {
			self.label.textColor = COLOR_NAV_TINT
			self.label.backgroundColor = COLOR_NAV_BARTINT
		}
	}

	func unhighlightCell() {
		UIView.animate(withDuration: 0.25) {
			self.label.textColor = .darkGray
			self.label.backgroundColor = COLOR_NAV_TINT
		}
	}

	required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}










