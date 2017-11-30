//
//  NavVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/25/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class NavVC: UIViewController {
    
    private let navOptions = [
        NavOption(title: "About Soltech", backgroundImageName: "backgroundImage", viewControllerType: AboutVC.self),
        NavOption(title: "Contact Us", backgroundImageName: "backgroundImage", viewControllerType: ContactVC.self)
    ]
    
    private let brandingView: UIImageView = {
        let bv = UIImageView(image: UIImage(named: "logo"))
        bv.contentMode = .scaleAspectFit
        bv.clipsToBounds = true
        bv.backgroundColor = .white
        return bv
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: UICollectionViewFlowLayout())
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        revealViewController().rearViewRevealDisplacement = view.frame.width / 4 * 3 / 2
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NavCell.self, forCellWithReuseIdentifier: "navCell")
        collectionView.backgroundColor = .white
        
        view.backgroundColor = .white
        
        view.addSubview(brandingView)
        view.addSubview(collectionView)
        
        constrain(brandingView, collectionView) { (bv, collectionView) in
            bv.top == bv.superview!.top
            bv.left == bv.superview!.left + 10
            bv.right == bv.superview!.right - (view.frame.width - revealViewController().rearViewRevealWidth)
			bv.height == bv.superview!.height / 5

            collectionView.top == bv.bottom
            collectionView.left == bv.superview!.left
            collectionView.right == bv.superview!.right - (view.frame.width - revealViewController().rearViewRevealWidth)
            collectionView.bottom == bv.superview!.bottom
        }
    }
}

extension NavVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return navOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "navCell", for: indexPath) as! NavCell
        cell.configureCell(title: navOptions[indexPath.item].title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let controller = UINavigationController(rootViewController: navOptions[indexPath.item].viewControllerType.init())
		present(controller, animated: true, completion: {
			self.toggleSideNav(self)
		})
	}
}

extension UIViewController {
	@objc func toggleSideNav(_ viewController: UIViewController) {

		revealViewController().revealToggle(animated: true)
	}
}





























