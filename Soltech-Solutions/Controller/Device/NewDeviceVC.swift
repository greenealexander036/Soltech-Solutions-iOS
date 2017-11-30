//
//  NewDeviceVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 10/3/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import RealmSwift
import SkyFloatingLabelTextField
import Cartography

class NewDeviceVC: UIViewController {
	private lazy var ipTextField: SkyFloatingLabelTextField = {
		let text = SkyFloatingLabelTextField(frame: CGRect.zero)
		text.placeholder = "IP Address"
		text.addTarget(self, action: #selector(ipTextChanged(_:)), for: .editingChanged)
		text.keyboardType = .decimalPad
		return text
	}()

	private lazy var nameTextField: SkyFloatingLabelTextField = {
		let text = SkyFloatingLabelTextField(frame: CGRect.zero)
		text.placeholder = "Name"
		text.autocapitalizationType = .words
		text.autocorrectionType = .no
		return text
	}()

	private lazy var saveBtn: UIBarButtonItem = {
		let btn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnPressed))
		btn.isEnabled = false
		return btn
	}()

	private lazy var lightCycleSelectBtn: UIButton = {
		let btn = UIButton(type: .custom)
		btn.setTitle("Select Light Cycle", for: .normal)
		btn.setTitleColor(COLOR_NAV_TINT, for: .normal)
		btn.backgroundColor = COLOR_NAV_BARTINT
		btn.layer.cornerRadius = 5
		btn.addTarget(self, action: #selector(selectLightCycle), for: .touchUpInside)
		return btn
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: COLOR_NAV_TINT]
		navigationController?.navigationBar.tintColor = COLOR_NAV_TINT
		navigationController?.navigationBar.barTintColor = COLOR_NAV_BARTINT
		navigationItem.title = "New Device"
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnPressed))
		navigationItem.rightBarButtonItem = saveBtn

		view.addSubview(nameTextField)
		view.addSubview(ipTextField)
		view.addSubview(lightCycleSelectBtn)

		constrain(nameTextField, ipTextField, lightCycleSelectBtn) { (name, ip, light) in
			name.bottom == ip.top - 20
			name.width == name.superview!.width * 0.75
			name.height == 50
			name.centerX == name.superview!.centerX

			ip.height == 50
			ip.centerX == ip.superview!.centerX
			ip.centerY == ip.superview!.centerY
			ip.width == ip.superview!.width * 0.75

			light.top == ip.bottom + 30
			light.width == light.superview!.width * 0.75
			light.height == 40
			light.centerX == light.superview!.centerX
		}
	}

	@objc private func cancelBtnPressed() {
		dismiss(animated: true, completion: nil)
	}

	@objc private func saveBtnPressed() {
		addDeviceToRealm()
		dismiss(animated: true, completion: nil)
	}

	@objc private func ipTextChanged(_ textField: UITextField) {
		if let numChars = textField.text?.characters.count {
			if numChars < 7 {
				saveBtn.isEnabled = false
			} else {
				saveBtn.isEnabled = true
			}
		} else {
			saveBtn.isEnabled = false
		}
	}

	private func addDeviceToRealm() {
		guard let ip = ipTextField.text else { return }

		let realm = try! Realm()
		let device = RealmDevice()
		device.ip = ip
		try! realm.write {
			realm.add(device)
		}
	}

	@objc private func selectLightCycle() {
		let controller = PlantsVC()
		controller.newDeviceController = self
		navigationController?.pushViewController(controller, animated: true)
	}

	func selectBtnTitle(title: String) {
		lightCycleSelectBtn.setTitle(title, for: .normal)
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
}

class RealmDevice: Object {
	@objc dynamic var ip = ""
}
































