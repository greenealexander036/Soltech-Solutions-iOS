//
//  DeviceInfoVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 10/3/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

class DeviceInfoVC: PlantReceiverVC {

	var device: RealmDevice!
	private var realm: Realm!
	private var bundledRealm: Realm!

	private lazy var editBtn: UIBarButtonItem = {
		let btn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleEdit(_:)))
		btn.tag = 0
		return btn
	}()

	private lazy var endEditBtn: UIBarButtonItem = {
		let btn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(toggleEdit(_:)))
		btn.tag = 1
		return btn
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		realm = try! Realm()
		bundledRealm = try! Realm(configuration: realmConfig)

		view.backgroundColor = .white
		navigationItem.title = "Device Info"
		navigationItem.rightBarButtonItem = editBtn

		form
		+++ Section()
			<<< IntRow("isEditable") { row in
				row.value = 0
				row.hidden = true
			}
			<<< TextRow("name") { row in
				row.title = "Name"
				row.value = device.name
				row.cell.textField.isUserInteractionEnabled = false
			}.cellUpdate({ (cell, row) in
				if let editable = self.form.rowBy(tag: "isEditable") as? IntRow {
					cell.textField.isUserInteractionEnabled = editable.value != 0
				}
				row.value = self.device.name
			})
			<<< TextRow("ip") { row in
				row.title = "IP Address *"
				row.value =  device.ip
				row.cell.textField.isUserInteractionEnabled = false
				row.cell.textField.keyboardType = .decimalPad
				}.cellUpdate({ (cell, row) in
					if let editable = self.form.rowBy(tag: "isEditable") as? IntRow {
						cell.textField.isUserInteractionEnabled = editable.value != 0
					}
					row.value = self.device.ip
				})
		+++ Section(){ section in
				section.tag = "plantImage"
				section.header = {
					var header = HeaderFooterView<ImageHeaderView>(.callback({
						let view = ImageHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
						view.setImage(imageData: self.device.plant?.image, plantName: self.device.plant?.name)
						return view
					}))
					header.height = { 200 }
					return header
				}()
			}
			<<< ButtonRow("changePlant") { row in
				row.title = "Select a different plant"
				row.hidden = Condition.function(["isEditable"], { (form) -> Bool in
					let value = (form.rowBy(tag: "isEditable") as? IntRow)?.value ?? 0
					return value == 0
				})
				}.onCellSelection({ (cell, row) in
					let controller = PlantsVC()
					controller.viewControllerToReturnTo = self
					self.navigationController?.pushViewController(controller, animated: true)
				})
		+++ Section()
		+++ Section()
		+++ Section() { section in
				section.tag = "btns"
			}
			<<< ButtonRow("deleteBtn") { row in
				row.title = "Delete"
				row.cell.tintColor = .red
				row.hidden = Condition.function(["isEditable"], { (form) -> Bool in
					let value = (form.rowBy(tag: "isEditable") as? IntRow)?.value ?? 0
					return value != 0
				})
			}.onCellSelection({ (btn, row) in
				self.deleteDevice {
					self.navigationController?.popViewController(animated: true)
				}
			})
	}

	func changePlant(plant: RealmPlant) {
		selectedPlant = plant
		if let imageSection = form.sectionBy(tag: "plantImage") {
			let header = imageSection.header?.viewForSection(imageSection, type: .header) as! ImageHeaderView
			header.setImage(imageData: selectedPlant?.image, plantName: selectedPlant?.name)
			imageSection.reload()
		}
	}

	@objc private func toggleEdit(_ barButton: UIBarButtonItem) {
		switch barButton.tag {
		case 0:
			toggleUIChanges(isEditing: true)
		case 1:
			toggleUIChanges(isEditing: false)
		default:
			()
		}
	}

	private func toggleUIChanges(isEditing: Bool) {
		if isEditing {
			navigationItem.rightBarButtonItem = endEditBtn
			navigationItem.hidesBackButton = true
			if let row = form.rowBy(tag: "isEditable") as? IntRow {
				row.value = 1
			}
		} else {
			updateDevice {
				self.navigationItem.rightBarButtonItem = self.editBtn
				self.navigationItem.hidesBackButton = false
				if let row = self.form.rowBy(tag: "isEditable") as? IntRow {
					row.value = 0
				}
			}
		}
		if let btnSection = form.sectionBy(tag: "btns") {
			btnSection.reload()
		}
		if let nameRow = form.rowBy(tag: "name") as? TextRow {
			nameRow.updateCell()
		}
		if let ipRow = form.rowBy(tag: "ip") as? TextRow {
			ipRow.updateCell()
		}
		self.refreshForm()
	}

	private func updateDevice(_ completion: @escaping () -> ()) {
		guard let name = (form.rowBy(tag: "name") as? TextRow)?.value, name.characters.count > 0, let ip = (form.rowBy(tag: "ip") as? TextRow)?.value, ip.characters.count >= 7 else {
			let alertController = UIAlertController(title: "Could not make changes", message: "- Device must have a name\n- IP must be at least 7 characters long", preferredStyle: .alert)
			let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
			alertController.addAction(cancelAction)
			present(alertController, animated: true, completion: nil)
			return
		}
		try! realm.write {
			device.name = name
			device.ip = ip
			if let plant = selectedPlant {
				if let realmplant = realm.object(ofType: RealmPlant.self, forPrimaryKey: plant.id) {
					device.plant = realmplant
				} else {
					let value: [String:Any] = ["name": plant.name, "id": plant.id, "familyId": plant.familyId, "lightCycle": plant.lightCycle, "optimalLightIntensity": plant.optimalLightIntensity, "otherTips": plant.otherTips, "arduinoMessage": plant.arduinoMessage, "wateringTendencies": plant.wateringTendencies, "image": plant.image]
					device.plant = realm.create(RealmPlant.self, value: value, update: false)
				}
			}
			realm.add(device, update: true)
		}
		device = realm.object(ofType: RealmDevice.self, forPrimaryKey: device.id)
		selectedPlant = nil
		completion()
	}

	private func refreshForm() {
		for section in form.allSections {
			section.reload()
		}
	}

	override func refreshFormWithSelectedPlant() {
		if let imageSection = form.sectionBy(tag: "plantImage") {
			let header = imageSection.header?.viewForSection(imageSection, type: .header) as! ImageHeaderView
			header.setImage(imageData: selectedPlant?.image, plantName: selectedPlant?.name)
			imageSection.reload()
		}
	}

	private func deleteDevice(completion: @escaping () -> ()) {
		try! realm.write {
			realm.delete(device)
		}
		completion()
	}
}


























