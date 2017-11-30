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
	private var height: CGFloat = {
		switch UIDevice.current.model {
		case "iPad":
		 	return 400
		default:
			return 284
		}
	}()

	private lazy var headerView: StretchHeader = {
		let options = StretchHeaderOptions()
		options.position = .underNavigationBar
		let header = StretchHeader()
		header.stretchHeaderSize(headerSize: CGSize(width: view.frame.size.width, height: height),
		                         imageSize: CGSize(width: view.frame.size.width, height: height),
		                         controller: self,
		                         options: options)
		header.imageView.image = UIImage(named: "aboutImg")
		let textLabel = UILabel(frame: CGRect(x: 0, y: height - 64, width: view.frame.width, height: 64))
		textLabel.backgroundColor = .white
		textLabel.font = UIFont.boldSystemFont(ofSize: 24)
		textLabel.textColor = .black
		textLabel.text = "Our Story"
		textLabel.textAlignment = .center
		header.addSubview(textLabel)
		return header
	}()

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 50
		tableView.separatorStyle = .none
		tableView.allowsSelection = false
		tableView.tableHeaderView = headerView
		tableView.tableFooterView = footerView
		tableView.register(TextCell.self, forCellReuseIdentifier: "textCell")
		tableView.register(TopPeopleCell.self, forCellReuseIdentifier: "topPeopleCell")
		tableView.delegate = self
		tableView.dataSource = self
		return tableView
	}()

	private lazy var footerView: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
		return view
	}()

	private let closeBtn: UIButton = {
		let btn = UIButton()
		btn.setImage(UIImage(named: "x")?.withRenderingMode(.alwaysTemplate), for: .normal)
		btn.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
		return btn
	}()

	private lazy var navBar: MyCustomNavBar = {
		let view = MyCustomNavBar(frame: CGRect.zero, isTransparent: true, title: "Our Story", leftBarBtn: closeBtn, rightBarBtn: nil)
		return view
	}()

	private let texts = ["Operating out of Bethlehem, PA, Soltech Solutions develops green and energy efficient products to enhance your daily life. Together the team continues to design and handcraft our product lines with the mission of helping you live a healthier and happier. As we continue to grow, we pledge to never compromise quality for profit.", "We plan to keep our production in Bethlehem, Pennsylvania and will continue to expand and improve our product line. We are working closely with our township, community leaders, and multiple business incubators to bring jobs to our local nonprofits and will continue to reinvest money into the community.", "If you have any issues, comments, or questions, always feel free to contact us. We are here to serve you, our loyal customer!"]

	private var topPeople: Results<RealmPerson>!
	private var realm: Realm!

    override func viewDidLoad() {
        super.viewDidLoad()

		realm = try! Realm(configuration: realmConfig)
		topPeople = realm.objects(RealmPerson.self)

		view.addSubview(tableView)
		view.addSubview(navBar)

		constrain(navBar, tableView) { (nav, tableView) in
			nav.top == nav.superview!.top
			nav.right == nav.superview!.right
			nav.left == nav.superview!.left
			nav.height == 64

			tableView.top == tableView.superview!.top
			tableView.right == tableView.superview!.right
			tableView.left == tableView.superview!.left
			tableView.bottom == tableView.superview!.bottom
		}

        navigationItem.title = "Our Story"
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "x"), style: .plain, target: self, action: #selector(closeVC))
	}

	@objc private func closeVC() {
		dismiss(animated: true, completion: nil)
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
		if tableView.contentOffset.y >= height - 67 {
			navBar.isTransparent = false
			navBar.changeBarStyling()
		} else {
			navBar.isTransparent = true
			navBar.changeBarStyling()
		}
	}

	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		if tableView.contentOffset.y <= -150 {
			self.dismiss(animated: true, completion: nil)
		}
	}
}



























