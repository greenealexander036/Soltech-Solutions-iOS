//
//  PlantVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/25/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography
import RealmSwift
import Eureka

class PlantVC: UIViewController {
 	var plant: RealmPlant!
	var viewControllerToReturnTo: PlantReceiverVC!

	private let sectionTitles = ["Optimal Light Intensity:", "Light Cycle:", "Watering Tendencies:", "Other Tips:"]

	private lazy var headerView: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
		view.backgroundColor = COLOR_NAV_TINT
		return view
	}()

	private lazy var tableView: UITableView = {
		let tv = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
		tv.contentInset = UIEdgeInsets(top: view.frame.height - 300, left: 0, bottom: 65, right: 0)
		tv.separatorStyle = .none
		tv.showsVerticalScrollIndicator = false
		return tv
	}()
    
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var selectBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Select", for: .normal)
        btn.backgroundColor = COLOR_NAV_BARTINT
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 5
		btn.addTarget(self, action: #selector(selectBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(data: plant!.image)
        navigationItem.title = plant!.name

		headerView.addSubview(selectBtn)
		selectBtn.frame = CGRect(x: 20, y: 10, width: view.frame.width - 40, height: 40)

		tableView.tableHeaderView = headerView
		tableView.register(TextCell.self, forCellReuseIdentifier: "textCell")
		tableView.register(ImageCell.self, forCellReuseIdentifier: "imageCell")
		tableView.backgroundColor = .clear
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 75

		view.backgroundColor = .white
        view.addSubview(imageView)
		view.addSubview(tableView)

		tableView.frame = view.bounds
		imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 300)
    }

	@objc private func selectBtnPressed() {
		viewControllerToReturnTo.selectedPlant = plant
		returnToViewOriginViewController {
			self.viewControllerToReturnTo.refreshFormWithSelectedPlant()
		}
	}

	private func returnToViewOriginViewController(_ completion: @escaping () -> ()) {
		self.navigationController?.unwind(for: UIStoryboardSegue.init(identifier: "id", source: self, destination: self.viewControllerToReturnTo), towardsViewController: self.viewControllerToReturnTo)
		completion()
	}
}

extension PlantVC: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 4
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var textCell: TextCell
		var imageCell: ImageCell
		let fontSize: CGFloat = 18

		var returnCell = UITableViewCell()
		let section = indexPath.section
		switch section {
		case 0:
			textCell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! TextCell
			var text = ""
			switch plant!.optimalLightIntensity {
			case 0:
				text = "Low"
			case 1:
				text = "Medium"
			case 2:
				text = "High"
			default:
				()
			}
			textCell.configureCell(text: text, fontSize: fontSize)
			returnCell = textCell
		case 1:
			textCell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! TextCell
			textCell.configureCell(text: plant?.lightCycle ?? "", fontSize: fontSize)
			returnCell = textCell
		case 2:
			imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImageCell
			imageCell.configureCell(imageData: plant?.image ?? Data())
			returnCell = imageCell
		case 3:
			textCell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! TextCell
			textCell.configureCell(text: plant?.otherTips ?? "", fontSize: fontSize)
			returnCell = textCell
		default:
			print("Error occurred")
		}
		return returnCell
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let text = sectionTitles[section]
		let headerView = CellHeaderView()
		headerView.configureHeaderTitle(title: text)
		return headerView
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 50
	}

	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return CGFloat.leastNormalMagnitude
	}

	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let view = UIView(frame: CGRect.zero)
		return view
	}
}


class PlantReceiverVC: FormViewController {
	var selectedPlant: RealmPlant?

	func refreshFormWithSelectedPlant() {}
}





















