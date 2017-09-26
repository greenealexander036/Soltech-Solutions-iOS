//
//  PlantFamiliesVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/25/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class PlantFamiliesVC: UIViewController {
    
    private let plantFamilies = [
        Plant(name: "Common House Plants", imageName: "herbs"),
        Plant(name: "Dwarf Fruit Trees", imageName: "herbs"),
        Plant(name: "Orchids", imageName: "herbs"),
        Plant(name: "Herbs", imageName: "herbs"),
    ]
    
    private let imageView: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "orange")
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.title = "Plant Families"
        
        collectionView.register(PlantCell.self, forCellWithReuseIdentifier: "plantCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(imageView)
        view.addSubview(collectionView)
        
        constrain(imageView, collectionView) { (img, cv) in
            img.top == img.superview!.top
            img.right == img.superview!.right
            img.left == img.superview!.left
            img.height == view.frame.height / 4
            
            cv.top == img.bottom
            cv.left == img.superview!.left
            cv.right == img.superview!.right
            cv.bottom == img.superview!.bottom
        }
    }
}

extension PlantFamiliesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plantFamilies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantCell", for: indexPath) as! PlantCell
        cell.configureCell(imageName: plantFamilies[indexPath.item].imageName, labelText: plantFamilies[indexPath.item].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 20, height: collectionView.frame.height / 2 - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PlantsVC()
        controller.navigationItem.title = plantFamilies[indexPath.item].name
        navigationController?.pushViewController(controller, animated: true)
    }
}




















