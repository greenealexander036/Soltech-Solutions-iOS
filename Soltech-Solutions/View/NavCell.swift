//
//  NavCell.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/25/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class NavCell: UITableViewCell {
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
        contentView.addSubview(label)
		contentView.backgroundColor = .white

		constrain(label) { (label) in
            label.top == label.superview!.top
            label.right == label.superview!.right
            label.left == label.superview!.left + 20
            label.bottom == label.superview!.bottom
			label.height == 50
        }
    }
    
	func configureCell(title: String, fontSize: CGFloat) {
        label.text = title
		label.font = UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
