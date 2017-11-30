//
//  RealmModels.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/29/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmPlant: Object {
	@objc dynamic var id = 0
	@objc dynamic var name = ""
	@objc dynamic var familyId = 0
	@objc dynamic var image = Data()
	@objc dynamic var optimalLightIntensity = 0
	@objc dynamic var lightCycle = ""
	@objc dynamic var wateringTendencies = Data()
	@objc dynamic var otherTips = ""
	@objc dynamic var arduinoMessage = ""

	override static func primaryKey() -> String? {
		return "id"
	}
}

class RealmPerson: Object {
	@objc dynamic var name = ""
	@objc dynamic var position = ""
	@objc dynamic var image = Data()
}

class RealmDevice: Object {
	@objc dynamic var id = ""
	@objc dynamic var ip = ""
	@objc dynamic var name = ""
	@objc dynamic var plant: RealmPlant? = nil
	@objc dynamic var isOn = false

	override static func primaryKey() -> String? {
		return "id"
	}
}

class RealmLocalAuth: Object {
	@objc dynamic var id = 0
	@objc dynamic var passcode = ""
	@objc dynamic var passcodeType = 0 // there are 4 possible types see TOPasscodeViewController on github for clarification
	@objc dynamic var isBiometricsAuthEnabled = false

	override static func primaryKey() -> String? {
		return "id"
	}
}
















