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
        HomeOption(title: "Home", backgroundImageName: "backgroundImage", viewControllerType: HomeVC.self),
        HomeOption(title: "Plants", backgroundImageName: "backgroundImage", viewControllerType: PlantsVC.self),
        HomeOption(title: "Connect", backgroundImageName: "backgroundImage", viewControllerType: ConnectVC.self),
        HomeOption(title: "On/Off", backgroundImageName: "backgroundImage", viewControllerType: OnOffVC.self),
        HomeOption(title: "About Soltech", backgroundImageName: "backgroundImage", viewControllerType: AboutVC.self),
        HomeOption(title: "Contact Us", backgroundImageName: "backgroundImage", viewControllerType: ContactVC.self)
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
        revealViewController().rearViewRevealWidth = view.frame.width / 4 * 3
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
            bv.right == bv.superview!.right - (view.frame.width - (view.frame.width / 4 * 3))
            bv.height == 150
            
            collectionView.top == bv.bottom
            collectionView.left == bv.superview!.left
            collectionView.right == bv.superview!.right - (view.frame.width - (view.frame.width / 4 * 3))
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
        return CGSize(width: view.frame.width / 4 * 3, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}





























