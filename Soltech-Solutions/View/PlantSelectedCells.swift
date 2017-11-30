//
//  PlantSelectedCells.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/27/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class TextCell: UITableViewCell {
	private let label: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		return label
	}()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		contentView.addSubview(label)

		constrain(label) { (label) in
			label.top == label.superview!.top + 8
			label.right == label.superview!.right - 20
			label.left == label.superview!.left + 20
			label.bottom == label.superview!.bottom - 8
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configureCell(text: String, fontSize: CGFloat) {
		label.text = text
		label.font = UIFont.systemFont(ofSize: fontSize)
	}
}

class ImageCell: UITableViewCell {
	private let fillImage: UIImageView = {
		let img = UIImageView()
		img.contentMode = .scaleAspectFill
		img.clipsToBounds = true
		return img
	}()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		contentView.addSubview(fillImage)

		constrain(fillImage) { (img) in
			img.top == img.superview!.top
			img.right == img.superview!.right
			img.left == img.superview!.left
			img.bottom == img.superview!.bottom
			img.height == 150
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configureCell(imageData: Data) {
		fillImage.image = UIImage(data: imageData)
	}
}

class CellHeaderView: UIView {

	private let label: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = UIFont.boldSystemFont(ofSize: 18)
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		addSubview(label)
		backgroundColor = .white

		constrain(label) { (label) in
			label.top == label.superview!.top
			label.right == label.superview!.right - 20
			label.left == label.superview!.left + 10
			label.bottom == label.superview!.bottom
		}
	}

	func configureHeaderTitle(title: String) {
		label.text = title
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}





























