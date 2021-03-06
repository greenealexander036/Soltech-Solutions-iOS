//
//  AppDelegate.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/24/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import RealmSwift
import TOPasscodeViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
	private var realm: Realm?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
		let frontVC = UINavigationController(rootViewController: DevicesVC())
		let rearVC = NavVC()
		let swreveal = SWRevealViewController(rearViewController: rearVC, frontViewController: frontVC)
        window?.rootViewController = swreveal

		UIApplication.shared.statusBarStyle = .lightContent

		return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
		realm = try! Realm()

		guard let realm = realm else { return }

		let localAuth = realm.object(ofType: RealmLocalAuth.self, forPrimaryKey: 0)

		if let localAuth = localAuth {
			if localAuth.passcode.characters.count > 0 {
				if localAuth.isBiometricsAuthEnabled {
					print("touchid")
				} else {
					print("passcode")
				}
			}
		} else {
			print("unprotected")
		}
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
		realm = try! Realm()

		guard let realm = realm else { return }

		let localAuth = realm.object(ofType: RealmLocalAuth.self, forPrimaryKey: 0)

		if let localAuth = localAuth {
			if localAuth.passcode.characters.count > 0 {
				if localAuth.isBiometricsAuthEnabled {
					print("touchid")
				} else {
					print("passcode")
				}
			}
		} else {
			print("unprotected")
		}
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

