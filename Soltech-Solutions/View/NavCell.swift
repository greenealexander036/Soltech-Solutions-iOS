//
//  NavCell.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/25/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class NavCell: UICollectionViewCell {
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        contentView.addSubview(seperatorView)
        constrain(label, seperatorView) { (label, view) in
            label.top == label.superview!.top
            label.right == label.superview!.right
            label.left == label.superview!.left + 20
            label.bottom == view.top
            
            view.bottom == view.superview!.bottom
            view.height == 1
            view.left == view.superview!.left + 20
            view.right == view.superview!.right
        }
    }
    
    func configureCell(title: String) {
        label.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
