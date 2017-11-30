//
//  DevicesVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/25/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation

class DevicesVC: UIViewController {
	private var realm: Realm!
	private var devices: Results<RealmDevice>!
	private var notificationToken: NotificationToken!

	private let tableView: UITableView = {
		let tableView = UITableView(frame: CGRect.zero)
		tableView.separatorStyle = .none
		return tableView
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

		realm = try! Realm()
		devices = realm.objects(RealmDevice.self)
		notificationToken = devices.addNotificationBlock({ (changes) in
			switch changes {
			case .initial:
				print("initial")
			case .update(_, let deletions, let insertions, let modifications):
				self.tableView.beginUpdates()
				self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
				self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: UITableViewRowAnimation.fade)
				self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .none)
				self.tableView.endUpdates()
			case .error(let error):
				fatalError(String(describing: error))
			}
		})

		view.backgroundColor = .white

		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
		view.addSubview(tableView)

		tableView.frame = view.bounds

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
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellid")!
		cell.textLabel?.text = devices[indexPath.row].ip
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
		let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
			try! self.realm.write {
				self.realm.delete(self.devices[indexPath.row])
			}
		}
		return [delete]
	}

	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
}
































