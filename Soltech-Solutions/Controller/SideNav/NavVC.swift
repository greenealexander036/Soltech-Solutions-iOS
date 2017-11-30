//
//  NavVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/25/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import MessageUI
import Cartography
import MapKit

class NavVC: UIViewController {
	let strArray = ["About Us", "Contact Us", "Settings"]
//	let strArray = ["About Us", "Contact Us"]
	var interactor = SwipeDownToDimissInteractor()
    
    private lazy var brandingView: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        let bv = UIImageView(image: UIImage(named: "logo"))
		view.addSubview(bv)
		bv.frame = CGRect(x: 20, y: 0, width: view.bounds.width - 40, height: view.bounds.height)
        bv.contentMode = .scaleAspectFit
        bv.clipsToBounds = true
        bv.backgroundColor = .white
        return view
    }()

	private let tableView: UITableView = {
		let tableView = UITableView(frame: CGRect.zero)
		tableView.separatorStyle = .none
		tableView.backgroundColor = .white
		tableView.alwaysBounceVertical = false
		return tableView
	}()
    
    override func viewDidLoad() {
        super.viewDidLoad()

		var width: CGFloat = 0

		switch UIDevice.current.model {
		case "iPad":
			revealViewController().rearViewRevealWidth = view.frame.width * 0.3
			width = view.frame.width * 0.3
		default:
			revealViewController().rearViewRevealWidth = view.frame.width * 0.6
			width = view.frame.width * 0.6
		}

        navigationController?.navigationBar.isTranslucent = false
		view.backgroundColor = .white
		tableView.frame = CGRect(x: 0, y: 0, width: width, height: view.frame.height)
		view.addSubview(tableView)

		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(NavCell.self, forCellReuseIdentifier: "navCell")
		tableView.rowHeight = 50
		tableView.backgroundColor = COLOR_NAV_TINT
		tableView.tableHeaderView = brandingView
		tableView.tableFooterView = setupFooterView()
    }

	private func setupFooterView() -> UIView {
		let view = UIView()
		view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 150)
		let btn = UIButton(type: .system)
		btn.setTitle("Join our Newsletter", for: .normal)
		btn.backgroundColor = COLOR_NAV_BARTINT
		btn.setTitleColor(COLOR_NAV_TINT, for: .normal)
		btn.layer.cornerRadius = 5
		btn.layer.shadowColor = UIColor.black.cgColor
		btn.layer.shadowOffset = CGSize(width: 0, height: 2)
		btn.layer.shadowOpacity = 0.2
		btn.addTarget(self, action: #selector(newsLetterBtnPressed), for: .touchUpInside)
		btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		view.addSubview(btn)
		constrain(btn) { (btn) in
			btn.bottom == btn.superview!.bottom
			btn.left == btn.superview!.left + 20
			btn.right == btn.superview!.right - 20
			btn.height == 40
		}
		return view
	}

	@objc private func newsLetterBtnPressed() {
		let controller = JoinNewsletterModal()
		controller.modalPresentationStyle = .overCurrentContext
		controller.modalTransitionStyle = .crossDissolve
		present(controller, animated: true, completion: nil)
	}

	@objc private func showActionSheet(for view: UIView) {
		let alertController = UIAlertController(title: "Choose Contact Method", message: nil, preferredStyle: .actionSheet)
		if let popoverController = alertController.popoverPresentationController {
			popoverController.sourceView = view
			popoverController.sourceRect = view.bounds
		}
		let emailAction = UIAlertAction(title: "Email - contactus@stsltn.com", style: .default) { (action) in
			let emailViewController = MFMailComposeViewController()
			emailViewController.mailComposeDelegate = self
			emailViewController.setToRecipients(["contactus@stsltn.com"])
			emailViewController.mailComposeDelegate = self
			emailViewController.setSubject("Help")
			emailViewController.setMessageBody("Need some help", isHTML: false)

			if MFMailComposeViewController.canSendMail() {
				self.present(emailViewController, animated: true, completion: nil)
			} else {
				print("could not send email")
			}
		}
		let phoneAction = UIAlertAction(title: "Phone - +1 (484) 821-1001", style: .default) { (action) in
			self.makeCall()
		}
		let directionsAction = UIAlertAction(title: "Get Directions", style: .default) { (action) in
			self.openMapForPlace()
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
		alertController.addAction(cancelAction)
		alertController.addAction(directionsAction)
		if UIDevice.current.model == "iPhone" {
			alertController.addAction(phoneAction)
		}
		alertController.addAction(emailAction)
		present(alertController, animated: true, completion: nil)
	}

	private func makeCall() {
		if let url = URL(string: "tel://+14848211001"), UIApplication.shared.canOpenURL(url) {
			if #available(iOS 10, *) {
				UIApplication.shared.open(url)
			} else {
				UIApplication.shared.openURL(url)
			}
		}
	}

	private func openMapForPlace() {
		let latitude: CLLocationDegrees = 40.6107331
		let longitude: CLLocationDegrees = -75.37118329999998

		let regionDistance:CLLocationDistance = 150
		let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
		let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
		let options = [
			MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
			MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
		]
		let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
		let mapItem = MKMapItem(placemark: placemark)
		mapItem.name = "Soltech Solutions\n520 Evans St #5,\nBethlehem, PA 18015,\nUSA"
		mapItem.openInMaps(launchOptions: options)
	}
}

extension NavVC: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return strArray.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "navCell") as! NavCell
		cell.configureCell(title: strArray[indexPath.row], fontSize: 24)
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		let row = indexPath.row
		switch row {
		case 0:
			present(AboutVC(), animated: true)
		case 1:
			let cell = tableView.cellForRow(at: indexPath)!
			showActionSheet(for: cell.contentView)
		case 2:
			let controller = SettingsVC()
//			controller.interactor = interactor
			let navController = UINavigationController(rootViewController: controller)
//			navController.delegate = self
			present(navController, animated: true)
		default:
			()
		}
	}
}

extension NavVC: MFMailComposeViewControllerDelegate {
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		dismiss(animated: true, completion: nil)
	}
}

extension UIViewController {
	@objc func toggleSideNav(_ viewController: UIViewController) {
		revealViewController().revealToggle(animated: true)
	}
}

/*extension NavVC: UIViewControllerTransitioningDelegate {
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return SwipeDownToDismissAnimator()
	}

	func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		return interactor.hasStarted ? interactor : nil
	}
}

extension NavVC: UINavigationControllerDelegate {
	func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		return interactor.hasStarted ? interactor : nil
	}

	func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		print(operation.rawValue)
		return SwipeDownToDismissAnimator()
	}
}*/



























