//
//  NewDeviceVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 10/3/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import RealmSwift
import Eureka

class NewDeviceVC: PlantReceiverVC {

	private var realm: Realm!

	override func viewDidLoad() {
		super.viewDidLoad()

		realm = try! Realm()

		view.backgroundColor = .white
		
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: COLOR_NAV_TINT]
		navigationController?.navigationBar.tintColor = COLOR_NAV_TINT
		navigationController?.navigationBar.barTintColor = COLOR_NAV_BARTINT
		navigationItem.title = "New Device"
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnPressed))
		tableView.separatorStyle = .none

		form +++ Section()
			<<< TextRow("nameRow") { row in
				row.title = "Name *"
				row.placeholder = "Enter a name"
				row.cell.textField.autocapitalizationType = .words
				row.cell.textField.autocorrectionType = .no
			}
			<<< TextRow("ipRow") { row in
				row.title = "IP Address *"
				row.placeholder = "Enter IP Address"
				row.cell.textField.autocorrectionType = .no
				row.cell.textField.keyboardType = .decimalPad
			}
			+++ Section(){ section in
				section.tag = "plantImage"
				section.header = {
					var header = HeaderFooterView<ImageHeaderView>(.callback({
						let view = ImageHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
						return view
					}))
					header.height = { 200 }
					return header
				}()
			}
			<<< ButtonRow("selectPlantBtn") { row in
					row.title = "Select Plant"
				}.onCellSelection({ (str, row) in
					self.selectLightCycle()
				})
			+++ Section()
			<<< ButtonRow() { row in
				row.title = "Save"
				row.disabled = Condition.function(["nameRow", "ipRow"], { form in
					let nameRowValue = (form.rowBy(tag: "nameRow") as! TextRow).value ?? ""
					let ipRowValue = (form.rowBy(tag: "ipRow") as! TextRow).value ?? ""
					return !(nameRowValue.characters.count > 0 && ipRowValue.characters.count >= 7)
				})
				}.onCellSelection({ (sectionName, row) in
					self.addDeviceToRealm {
						self.dismiss(animated: true, completion: nil)
					}
				})
			+++ Section("* required fields")
	}

	@objc private func cancelBtnPressed() {
		dismiss(animated: true, completion: nil)
	}

	private func addDeviceToRealm(_ completion: @escaping () -> ()) {
		let device = RealmDevice()
		let valuesDict = form.values()
		if let ip = valuesDict["ipRow"] as? String {
			device.ip = ip
		}
		if let name = valuesDict["nameRow"] as? String {
			device.name = name
		}
		try! realm.write {
			if let plant = selectedPlant {
				if let realmplant = realm.object(ofType: RealmPlant.self, forPrimaryKey: plant.id) {
					device.plant = realmplant
				} else {
					let value: [String:Any] = ["name": plant.name, "id": plant.id, "familyId": plant.familyId, "lightCycle": plant.lightCycle, "optimalLightIntensity": plant.optimalLightIntensity, "otherTips": plant.otherTips, "arduinoMessage": plant.arduinoMessage, "wateringTendencies": plant.wateringTendencies, "image": plant.image]
					device.plant = realm.create(RealmPlant.self, value: value, update: false)
				}
			}
			let id = UUID().uuidString
			device.id = id
			realm.add(device)
		}
		completion()
	}

	override func refreshFormWithSelectedPlant() {
		if let selectBtn = form.rowBy(tag: "selectPlantBtn") {
			selectBtn.title = "Select a different plant"
		}
		if let imageSection = form.sectionBy(tag: "plantImage") {
			let header = imageSection.header?.viewForSection(imageSection, type: .header) as! ImageHeaderView
			header.setImage(imageData: selectedPlant?.image, plantName: selectedPlant?.name)
			imageSection.reload()
		}
	}

	@objc private func selectLightCycle() {
		let controller = PlantsVC()
		controller.viewControllerToReturnTo = self
		navigationController?.pushViewController(controller, animated: true)
	}
}



































