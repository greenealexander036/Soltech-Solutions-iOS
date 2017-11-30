//
//  PlantsVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/25/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography
import RealmSwift

class PlantsVC: UIViewController {
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return cv
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.autocapitalizationType = .none
        search.autocorrectionType = .no
		search.returnKeyType = .done
		search.tintColor = .white
		search.barTintColor = COLOR_NAV_BARTINT
		return search
    }()

	private var realm: Realm!
	private var plants: Results<RealmPlant>!
	var viewControllerToReturnTo: PlantReceiverVC!

    override func viewDidLoad() {
        super.viewDidLoad()

	 	realm = try! Realm(configuration: realmConfig)
		plants = realm.objects(RealmPlant.self)

		navigationItem.title = "Plants"

        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()

        searchBar.delegate = self

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PlantCell.self, forCellWithReuseIdentifier: "plantCell")
                
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        constrain(searchBar, collectionView) { (search, cv) in
            search.top == cv.superview!.top
            search.right == cv.superview!.right
            search.left == cv.superview!.left
            search.height == 50
            
            cv.top == search.bottom
            cv.left == cv.superview!.left
            cv.right == cv.superview!.right
            cv.bottom == cv.superview!.bottom
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension PlantsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantCell", for: indexPath) as! PlantCell
        cell.configureCell(imageData: plants[indexPath.item].image, labelText: plants[indexPath.item].name)
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = view.frame.width / 2 - 30
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PlantVC()
        controller.hidesBottomBarWhenPushed = true
        controller.plant = plants[indexPath.item]
		controller.viewControllerToReturnTo = viewControllerToReturnTo
		view.endEditing(true)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension PlantsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.characters.count == 0 {
			plants = realm.objects(RealmPlant.self)
		} else {
			plants = realm.objects(RealmPlant.self).filter("name contains[c] %@", searchText)
		}
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		searchBar.endEditing(true)
	}

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.endEditing(true)
	}

	func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
		searchBar.setShowsCancelButton(true, animated: true)
		return true
	}

	func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
		searchBar.setShowsCancelButton(false, animated: true)
		return true
	}
}















