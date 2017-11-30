//
//  Constants.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/26/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import RealmSwift

/* 			Realm			*/

let SERVER_URL = "http://localhost:9080"

let realmConfig: Realm.Configuration = {
	var config = Realm.Configuration()
	config.fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "soltech", ofType: "realm")!)
	config.readOnly = true
	return config
}()

/*			Colors			*/

// red UIColor(red: 0.72156862745098, green: 0.219607843137255, blue: 0.0, alpha: 1.0)
// light green UIColor(red: 0.596078455448151, green: 0.800000011920929, blue: 0.00784313771873713, alpha: 1.0)

// Navigation Bar Colors
let COLOR_GREEN = UIColor(red: 0.596078455448151, green: 0.800000011920929, blue: 0.00784313771873713, alpha: 1.0)
let COLOR_NAV_BARTINT = COLOR_GREEN
let COLOR_NAV_TINT = UIColor.white

