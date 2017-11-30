//
//  MyCustomNavBar.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 10/18/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class MyCustomNavBar: UIView {
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 24)
		label.textAlignment = .center
		return label
	}()

	private let dividerView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
		view.layer.opacity = 0
		return view
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	private var leftBtn: UIButton?
	private var rightBtn: UIButton?

	var isTransparent = false

	convenience init(frame: CGRect, isTransparent: Bool, title: String? = "", leftBarBtn: UIButton?, rightBarBtn: UIButton?) {
		self.init(frame: frame)
		self.isTransparent = isTransparent

		addSubview(titleLabel)

		constrain(titleLabel) { (title) in
			title.centerX == title.superview!.centerX
			title.bottom == title.superview!.bottom - 10
			title.width == title.superview!.width - 100
		}
		titleLabel.text = title
		titleLabel.textColor = COLOR_NAV_TINT
		backgroundColor = COLOR_NAV_BARTINT

		leftBtn = leftBarBtn
		rightBtn = rightBarBtn

		if let leftBtn = leftBtn {
			leftBtn.layer.cornerRadius = 15
			leftBtn.tintColor = .black
			leftBtn.backgroundColor = .white
			addSubview(leftBtn)

			constrain(leftBtn, block: { (left) in
				left.height == 30
				left.width == 30
				left.bottom == left.superview!.bottom - 10
				left.left == left.superview!.left + 20
			})
		}

		if let rightBtn = rightBtn {
			rightBtn.layer.cornerRadius = 15
			rightBtn.tintColor = .black
			rightBtn.backgroundColor = .white
			addSubview(rightBtn)

			constrain(rightBtn, block: { (right) in
				right.height == 30
				right.width == 30
				right.bottom == right.superview!.bottom - 10
				right.right == right.superview!.right - 20
			})
		}
		changeBarStyling()
		addSubview(dividerView)

		constrain(dividerView) { (div) in
			div.height == 1
			div.left == div.superview!.left
			div.right == div.superview!.right
			div.bottom == div.superview!.bottom
		}
	}

	func changeBarStyling() {
		if isTransparent {
			self.backgroundColor = .clear
			self.titleLabel.textColor = .clear
			dividerView.layer.opacity = 0
		} else {
			self.backgroundColor = .white
			self.titleLabel.textColor = .black
			dividerView.layer.opacity = 1
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
