//
//  LocalAuthConfigVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 10/19/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift
import Cartography
import TOPasscodeViewController

class LocalAuthConfigVC: FormViewController {

	private var realm: Realm!
	private var realmLocalAuthObject: RealmLocalAuth?

	override func viewDidLoad() {
		super.viewDidLoad()

		realm = try! Realm()
		realmLocalAuthObject = realm.object(ofType: RealmLocalAuth.self, forPrimaryKey: 0)

		form +++ Section()
			<<< IntRow("localAuthNotNil") {
				$0.value = realmLocalAuthObject != nil ? 1 : 0
				$0.hidden = true
			}
			<<< SwitchRow() {
				$0.title = "Passcode Enabled"
				if let _ = realmLocalAuthObject {
					$0.value = true
				} else {
					$0.value = false
				}
			}
			.onChange({ (row) in
				if let isPasscodeEnabled = row.value {
					if isPasscodeEnabled {
						let controller = TOPasscodeSettingsViewController()
						controller.delegate = self
						self.present(controller, animated: true) {
							(self.form.rowBy(tag: "localAuthNotNil") as! IntRow).value = 1
						}
					} else {
						if let authObject = self.realmLocalAuthObject {
							try! self.realm.write {
								self.realm.delete(authObject)
								self.realmLocalAuthObject = nil
							}
						 	(self.form.rowBy(tag: "localAuthNotNil") as! IntRow).value = 0
						}
					}
				}
			})
			<<< ButtonRow() {
				$0.title = "Change Passcode"
				$0.hidden = Condition.function(["localAuthNotNil"], { (form) -> Bool in
					return (form.rowBy(tag: "localAuthNotNil") as! IntRow).value == 0
				})
				}
				.cellUpdate({ (cell, row) in
					row.hidden = Condition.function(["localAuthNotNil"], { (form) -> Bool in
						return (form.rowBy(tag: "localAuthNotNil") as! IntRow).value == 0
					})
				})
				.onCellSelection({ (cell, row) in
					let controller = TOPasscodeSettingsViewController()
					controller.delegate = self
					controller.requireCurrentPasscode = true
					self.present(controller, animated: true, completion: nil)
				})
			+++ Section()
			<<< SwitchRow() {
				$0.title = "Enable TouchID"
				$0.value = realmLocalAuthObject?.isBiometricsAuthEnabled ?? false
				$0.hidden = Condition.function(["localAuthNotNil"], { (form) -> Bool in
					return (form.rowBy(tag: "localAuthNotNil") as! IntRow).value == 0
				})
				}.onChange({ (row) in
					guard let realmLocalAuthObj = self.realmLocalAuthObject else { return }
					try! self.realm.write {
						realmLocalAuthObj.isBiometricsAuthEnabled = row.value ?? false
						self.realm.add(realmLocalAuthObj, update: true)
					}
				})
				.cellUpdate({ (cell, row) in
					row.value = self.realmLocalAuthObject?.isBiometricsAuthEnabled ?? false
				})
	}
}

extension LocalAuthConfigVC: TOPasscodeSettingsViewControllerDelegate {
	func passcodeSettingsViewController(_ passcodeSettingsViewController: TOPasscodeSettingsViewController, didChangeToNewPasscode passcode: String, of type: TOPasscodeType) {
		if let localAuthObject = realmLocalAuthObject {
			try! realm.write {
				localAuthObject.passcode = passcode
				realm.add(localAuthObject, update: true)
			}
		} else {
			let localAuthObject = RealmLocalAuth()
			localAuthObject.passcode = passcode
			try! realm.write {
				realm.add(localAuthObject)
			}
			self.realmLocalAuthObject = realm.object(ofType: RealmLocalAuth.self, forPrimaryKey: 0)
		}
		form.allSections.forEach { (section) in
			section.reload()
		}
		passcodeSettingsViewController.dismiss(animated: true, completion: nil)
	}

	func passcodeSettingsViewController(_ passcodeSettingsViewController: TOPasscodeSettingsViewController, didAttemptCurrentPasscode passcode: String) -> Bool {
		return passcode.elementsEqual(realmLocalAuthObject!.passcode)
	}


}
































