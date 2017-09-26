//
//  ViewController.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/24/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class HomeVC: UIViewController {
    
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        return cv
    }()

    private let homeOptions = [
        HomeOption(title: "Plants", backgroundImageName: "plants", viewControllerType: PlantFamiliesVC.self),
        HomeOption(title: "Connect", backgroundImageName: "wifi", viewControllerType: ConnectVC.self),
        HomeOption(title: "On/Off", backgroundImageName: "power", viewControllerType: OnOffVC.self),
        HomeOption(title: "About Soltech", backgroundImageName: "info", viewControllerType: AboutVC.self),
        HomeOption(title: "Contact Us", backgroundImageName: "contact", viewControllerType: ContactVC.self)
    ]
    
    private let titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        view.backgroundColor = .black
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private lazy var menuBtn: UIBarButtonItem = {
        let btn = UIButton(type: .custom)
        btn.imageView?.clipsToBounds = true
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "menu"), for: .normal)
        btn.addTarget(self, action: #selector(toggleSideNav), for: .touchUpInside)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return UIBarButtonItem(customView: btn)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = greenColor
        navigationController?.navigationBar.tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.isTranslucent = false

        navigationItem.leftBarButtonItem = menuBtn
        
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
        
        navigationItem.title = "Home"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "homeCell")
        
        view.addSubview(collectionView)
        constrain(collectionView) { (collectionView) in
            collectionView.top == collectionView.superview!.top
            collectionView.right == collectionView.superview!.right
            collectionView.left == collectionView.superview!.left
            collectionView.bottom == collectionView.superview!.bottom
        }
    }
    
    @objc private func toggleSideNav() {
        revealViewController().revealToggle(animated: true)
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCell
        cell.configureCell(title: homeOptions[indexPath.item].title, imageName: homeOptions[indexPath.item].backgroundImageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height/5 - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = homeOptions[indexPath.item].viewControllerType.init()
        navigationController?.pushViewController(controller, animated: true)
    }
}





























