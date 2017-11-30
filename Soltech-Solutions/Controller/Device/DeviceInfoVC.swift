//
//  DeviceInfoVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 10/3/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit

class DeviceInfoVC: UIViewController {

	var device: RealmDevice? 

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white
		navigationItem.title = device?.ip
	}
}
