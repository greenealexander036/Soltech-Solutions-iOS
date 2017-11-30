//
//  TopPeopleCell.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 10/10/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class TopPeopleCell: UITableViewCell {
	private let circleImgView: UIImageView = {
		let img = UIImageView(frame: CGRect.zero)
		img.contentMode = .scaleAspectFill
		img.clipsToBounds = true
		img.layer.cornerRadius = 40
		return img
	}()

	private let nameLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.textAlignment = .center
		return label
	}()

	private let positionLabel: UILabel = {
		let label = UILabel()
		label.textColor = .darkGray
		label.textAlignment = .center
		return label
	}()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		contentView.addSubview(circleImgView)
		contentView.addSubview(nameLabel)
		contentView.addSubview(positionLabel)

		constrain(circleImgView, nameLabel, positionLabel) { (img, name, pos) in
			img.top == img.superview!.top + 20
			img.width == 80
			img.height == 80
			img.centerX == img.superview!.centerX

			name.top == img.bottom + 8
			name.right == name.superview!.right - 8
			name.left == name.superview!.left + 8
			name.height == 30

			pos.top == name.bottom
			pos.right == name.right
			pos.left == name.left
			pos.height == 30
			pos.bottom == pos.superview!.bottom
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configureCell(imageData: Data, name: String, position: String, nameFontSize: CGFloat, positionFontSize: CGFloat) {
		circleImgView.image = UIImage(data: imageData)
		nameLabel.text = name.uppercased()
		nameLabel.font = UIFont.systemFont(ofSize: nameFontSize)
		positionLabel.text = position
		positionLabel.font = UIFont.systemFont(ofSize: positionFontSize)
	}
}
