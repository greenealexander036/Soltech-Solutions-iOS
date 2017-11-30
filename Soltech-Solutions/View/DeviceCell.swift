//
//  DeviceCell.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 10/10/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class DeviceCell: UITableViewCell {
	private let boldFontSize: CGFloat = 18
	private let fontSize: CGFloat = 16

	private lazy var nameLabel: UILabel = {
		let label = createLabel(alignment: .left, fontSize: fontSize, isBold: false)
		label.text = "Name:"
		label.textColor = .darkGray
		return label
	}()

	private lazy var nameText: UILabel = {
		let label = createLabel(alignment: .left, fontSize: boldFontSize, isBold: true)
		return label
	}()

	private lazy var plantLabel: UILabel = {
		let label = createLabel(alignment: .left, fontSize: fontSize, isBold: false)
		label.text = "Light Cycle:"
		label.textColor = .darkGray
		return label
	}()

	private lazy var plantText: UILabel = {
		let label = createLabel(alignment: .left, fontSize: fontSize, isBold: true)
		label.textColor = .darkGray
		return label
	}()

	private let dividerView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
		return view
	}()

	private func createLabel(alignment: NSTextAlignment, fontSize: CGFloat, isBold: Bool) -> UILabel {
		let label = UILabel(frame: CGRect.zero)
		label.textAlignment = alignment
		if isBold {
			label.font = UIFont.boldSystemFont(ofSize: fontSize)
		} else {
			label.font = UIFont.systemFont(ofSize: fontSize)
		}
		return label
	}

	private func createStackView(withAxis axis: UILayoutConstraintAxis, spacing: CGFloat, views: UIView...) -> UIStackView {
		let stackView = UIStackView(arrangedSubviews: views)
		stackView.axis = axis
		stackView.spacing = spacing
		stackView.alignment = .leading
		return stackView
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		let nameStackView = createStackView(withAxis: .horizontal, spacing: 5, views: nameLabel, nameText)
		let plantStackView = createStackView(withAxis: .horizontal, spacing: 5, views: plantLabel, plantText)
		let fullStackView = createStackView(withAxis: .vertical, spacing: 10, views: nameStackView, plantStackView)

		contentView.addSubview(fullStackView)
		contentView.addSubview(dividerView)

		constrain(fullStackView, dividerView) { (stackView, divider) in
			stackView.top == stackView.superview!.top + 20
			stackView.right == stackView.superview!.right - 20
			stackView.left == stackView.superview!.left + 20
			stackView.bottom == divider.bottom - 19

			divider.height == 1
			divider.width == divider.superview!.width + 18
			divider.right == divider.superview!.right + 38
			divider.bottom == divider.superview!.bottom
		}
	}

	func configureCell(device: RealmDevice) {
		nameText.text = device.name
		plantText.text = device.plant?.name ?? "None selected"
		let imageView = UIImageView(image: UIImage(named: "onoff")?.withRenderingMode(.alwaysTemplate))
		imageView.contentMode = .scaleAspectFit
		if device.isOn {
			imageView.tintColor = COLOR_NAV_BARTINT
		} else {
			imageView.tintColor = .red
		}
		accessoryView = imageView
		accessoryView?.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
