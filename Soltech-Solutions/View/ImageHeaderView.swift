//
//  ImageHeaderView.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 10/10/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class ImageHeaderView: UIView {
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.layer.opacity = 0
		return imageView
	}()

	private let plantNameLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .darkGray
		return label
	}()

	private let label: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.textAlignment = .center
		label.text = "No plant selected yet"
		label.textRect(forBounds: CGRect(x: 10, y: 0, width: label.frame.width, height: label.frame.height), limitedToNumberOfLines: 1)
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white

		addSubview(label)
		label.frame = bounds

		let view = UIView(frame: bounds)
		addSubview(view)

		view.addSubview(imageView)
		view.addSubview(plantNameLabel)

		constrain(imageView, plantNameLabel) { (img, plant) in
			img.top == img.superview!.top
			img.right == img.superview!.right
			img.left == img.superview!.left
			img.height == img.superview!.height * 0.8

			plant.top == img.bottom
			plant.right == plant.superview!.right
			plant.left == plant.superview!.left
			plant.bottom == plant.superview!.bottom
		}
	}

	func setImage(imageData: Data?, plantName: String?) {
		if let data = imageData {
			imageView.layer.opacity = 1
			imageView.image = UIImage(data: data)
			label.layer.opacity = 0
		}

		if let name = plantName {
			plantNameLabel.text = name
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
