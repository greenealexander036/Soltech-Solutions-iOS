//
//  DevicesVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/25/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import RealmSwift
import Cartography
import Alamofire

class DevicesVC: UIViewController {
	private var realm: Realm!
	private var devices: Results<RealmDevice>!
	private var notificationToken: NotificationToken!

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.separatorStyle = .none
		tableView.estimatedRowHeight = 285
		tableView.rowHeight = UITableViewAutomaticDimension
		return tableView
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

		realm = try! Realm()
		devices = realm.objects(RealmDevice.self)
		notificationToken = devices.observe({ (changes) in
			switch changes {
			case .initial:
				()
			case .update(_, let deletions, let insertions, let modifications):
				self.tableView.beginUpdates()
				self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
				self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .fade)
				self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
				self.tableView.endUpdates()
			case .error(let error):
				fatalError(String(describing: error))
			}
		})

		view.backgroundColor = .white

		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(DeviceCell.self, forCellReuseIdentifier: "deviceCell")
		view.addSubview(tableView)

		constrain(tableView) { (tableView) in
			tableView.top == tableView.superview!.top
			tableView.right == tableView.superview!.right
			tableView.left == tableView.superview!.left
			tableView.bottom == tableView.superview!.bottom
		}

		view.addGestureRecognizer(revealViewController().panGestureRecognizer())
		view.addGestureRecognizer(revealViewController().tapGestureRecognizer())

		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: COLOR_NAV_TINT]
		navigationController?.navigationBar.barTintColor = COLOR_NAV_BARTINT
		navigationController?.navigationBar.tintColor = COLOR_NAV_TINT

		navigationItem.title = "Devices"
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(toggleSideNav))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnPressed))
    }

	@objc private func addBtnPressed() {
		present(UINavigationController(rootViewController: NewDeviceVC()), animated: true, completion: nil)
	}

	@objc private func updateDevices() {
		tableView.reloadData()
	}
}

extension DevicesVC: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return devices.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell") as! DeviceCell
		cell.configureCell(device: devices[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let device = devices[indexPath.row]
		let controller = DeviceInfoVC()
		controller.device = device
		navigationController?.pushViewController(controller, animated: true)
		tableView.deselectRow(at: indexPath, animated: false)
	}

	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		let device = self.devices[indexPath.row]
		let title = device.isOn ? "Off" : "On"
		let toggleOnOff = UITableViewRowAction(style: .normal, title: title) { (action, indexPath) in
			
			// send information somewhere for the arduino to interpret
			// after the sending of the information, and after we know it succeeded,
			// save the status of the device to the realm

			if !device.isOn {
				Alamofire.request("http://\(device.ip)/digital/1").responseJSON(completionHandler: { (response) in
					print("Request: \(String(describing: response.request))")
					print("Response: \(String(describing: response.response))")
					print("Result: \(String(describing: response.result))")

					if let json = response.result.value {
						print("JSON: \(json)")
					}

					if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
						print("Data: \(utf8Text)")
					}
				})
			} else {
				Alamofire.request("http://\(device.ip)/digital/0").responseJSON(completionHandler: { (response) in
					print("Request: \(String(describing: response.request))")
					print("Response: \(String(describing: response.response))")
					print("Result: \(String(describing: response.result))")

					if let json = response.result.value {
						print("JSON: \(json)")
					}

					if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
						print("Data: \(utf8Text)")
					}
				})
			}

			try! self.realm.write {
				device.isOn = !device.isOn
			}
		}
		toggleOnOff.backgroundColor = device.isOn ? UIColor.red : COLOR_GREEN
		return [toggleOnOff]
	}

	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
}
































