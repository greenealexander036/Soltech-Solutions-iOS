//
//  RoundedTextField.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 10/10/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit

class RoundedTextfield: UITextField {
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return CGRect(x: 15, y: 0, width: bounds.width, height: bounds.height)
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return CGRect(x: 15, y: 0, width: bounds.width, height: bounds.height)
	}

	convenience init(cornerRadius: CGFloat) {
		self.init()
		layer.cornerRadius = cornerRadius
		clipsToBounds = true
	}
}
