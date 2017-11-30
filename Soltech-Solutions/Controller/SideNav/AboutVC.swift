//
//  AboutVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/25/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import StretchHeader
import Cartography
import RealmSwift

class AboutVC: UIViewController {

	private lazy var headerView: StretchHeader = {
		let options = StretchHeaderOptions()
		options.position = .underNavigationBar
		let header = StretchHeader()
		header.stretchHeaderSize(headerSize: CGSize(width: view.frame.size.width, height: 220),
		                         imageSize: CGSize(width: view.frame.size.width, height: 220),
		                         controller: self,
		                         options: options)
		header.imageView.image = UIImage(named: "aboutImg")
		return header
	}()

	private let tableView: UITableView = {
		let tableView = UITableView(frame: CGRect.zero)
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 50
		tableView.separatorStyle = .none
		tableView.allowsSelection = false
		return tableView
	}()

	private lazy var footerView: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
		return view
	}()

	private let texts = ["Operating out of Bethlehem, PA, Soltech Solutions develops green and energy efficient products to enhance your daily life. Together the team continues to design and handcraft our product lines with the mission of helping you live a healthier and happier. As we continue to grow, we pledge to never compromise quality for profit.", "We plan to keep our production in Bethlehem, Pennsylvania and will continue to expand and improve our product line. We are working closely with our township, community leaders, and multiple business incubators to bring jobs to our local nonprofits and will continue to reinvest money into the community.", "If you have any issues, comments, or questions, always feel free to contact us. We are here to serve you, outr loyal customer!"]

	private var topPeople: Results<RealmPerson>!
	private var realm: Realm!

    override func viewDidLoad() {
        super.viewDidLoad()

		realm = try! Realm(configuration: realmConfig)
		topPeople = realm.objects(RealmPerson.self)

		navigationController?.navigationBar.barTintColor = COLOR_NAV_BARTINT
		navigationController?.navigationBar.tintColor = COLOR_NAV_TINT
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: COLOR_NAV_TINT]

		view.addSubview(tableView)
		tableView.frame = view.bounds
		tableView.tableHeaderView = headerView
		tableView.tableFooterView = footerView
		tableView.register(TextCell.self, forCellReuseIdentifier: "textCell")
		tableView.register(TopPeopleCell.self, forCellReuseIdentifier: "topPeopleCell")
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
		tableView.delegate = self
		tableView.dataSource = self

		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "closeBtn_24"), style: .plain, target: self, action: #selector(closeVC))
        view.backgroundColor = .white
        navigationItem.title = "Our Story"
    }

	@objc private func closeVC() {
		dismiss(animated: true, completion: nil)
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}

extension AboutVC: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return texts.count
		case 1:
			return topPeople.count
		default:
			return 1
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! TextCell
			cell.configureCell(text: texts[indexPath.row], fontSize: 18)
			return cell
		case 1:
			let cell = tableView.dequeueReusableCell(withIdentifier: "topPeopleCell") as! TopPeopleCell
			let topPerson = topPeople[indexPath.row]
			cell.configureCell(imageData: topPerson.image, name: topPerson.name, position: topPerson.position, nameFontSize: 24, positionFontSize: 14)
			return cell
		default:
			print("error")
		}
		return UITableViewCell(style: .subtitle, reuseIdentifier: "cellid")
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		headerView.updateScrollViewOffset(scrollView)
	}
}

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

class TopPerson {
	var name: String!
	var position: String!
	var imageName: String!

	init(name: String, position: String, imageName: String) {
		self.name = name
		self.position = position
		self.imageName = imageName
	}
}























