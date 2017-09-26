//
//  PlantsVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/25/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

let greenColor = UIColor(red: 0.596078455448151, green: 0.800000011920929, blue: 0.00784313771873713, alpha: 1.0)

class PlantsVC: UIViewController {
    
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        return cv
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.autocapitalizationType = .none
        search.autocorrectionType = .no
        return search
    }()
    
    private let plants = [
        Plant(name: "Plant 1", imageName: "orange"),
        Plant(name: "Plant 2", imageName: "orange"),
        Plant(name: "Plant 3", imageName: "orange"),
        Plant(name: "Plant 4", imageName: "orange"),
        Plant(name: "Plant 5", imageName: "orange"),
        Plant(name: "Plant 6", imageName: "orange"),
        Plant(name: "Plant 7", imageName: "orange"),
        Plant(name: "Plant 8", imageName: "orange")
    ]
    
    private var filteredPlants = [Plant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        searchBar.barTintColor = greenColor
        
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
        if filteredPlants.count > 0 {
            return filteredPlants.count
        }
        return plants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantCell", for: indexPath) as! PlantCell
        if filteredPlants.count > 0 {
            cell.configureCell(imageName: filteredPlants[indexPath.item].imageName, labelText: filteredPlants[indexPath.item].name)
        } else {
            cell.configureCell(imageName: plants[indexPath.item].imageName, labelText: plants[indexPath.item].name)
        }
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = view.frame.width / 2 - 20
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PlantVC()
        
        if filteredPlants.count > 0 {
            controller.plant = filteredPlants[indexPath.item]
        } else {
            controller.plant = plants[indexPath.item]
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension PlantsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPlants = plants.filter({ (plant) -> Bool in
            return plant.name.lowercased().contains(searchText.lowercased())
        })
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}















