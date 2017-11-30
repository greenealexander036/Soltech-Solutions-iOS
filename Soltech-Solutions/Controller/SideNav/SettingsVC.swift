//
//  SettingsVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 10/17/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Eureka
import Cartography

class SettingsVC: FormViewController {

//	var interactor: SwipeDownToDimissInteractor?

	private lazy var closeBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.setImage(UIImage(named: "x"), for: .normal)
		btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
		return btn
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

//		tableView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:))))

		navigationItem.title = "Settings"
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "x")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(handleDismiss))

		form +++ Section()
			<<< LabelRow() {
				$0.title = "TouchID & Passcode"
				$0.cell.accessoryType = .disclosureIndicator
			}.onCellSelection({ (cell, row) in
				self.navigationController?.pushViewController(LocalAuthConfigVC(), animated: true)
			})
	}

	/*@objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
		let percentThreshold: CGFloat = 0.3
		let translation = gesture.translation(in: view)
		let verticalMovement = translation.y / view.bounds.height
		let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
		let downwardMovementPercent = fminf(downwardMovement, 1.0)
		let progress = CGFloat(downwardMovementPercent)

		guard let interactor = interactor else { return }

		switch gesture.state {
		case .began:
			interactor.hasStarted = true
			self.dismiss(animated: true, completion: nil)
		case .changed:
			interactor.shouldFinish = progress > percentThreshold
			interactor.update(progress)
		case .cancelled:
			interactor.hasStarted = false
			interactor.cancel()
		case .ended:
			interactor.hasStarted = false
			interactor.shouldFinish ? interactor.finish() : interactor.cancel()
		default:
			break
		}
	}*/
}

extension UIViewController {
	@objc func handleDismiss() {
		dismiss(animated: true, completion: nil)
	}
}

class Setting {
	var title: String!

}
