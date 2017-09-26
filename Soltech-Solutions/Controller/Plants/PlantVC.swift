//
//  PlantVC.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/25/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit
import Cartography

class PlantVC: UIViewController {
    
    var plant: Plant?
    
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private let selectBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Select", for: .normal)
        btn.backgroundColor = .red
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.backgroundColor = .yellow
        imageView.image = UIImage(named: plant?.imageName ?? "")
        navigationItem.title = plant?.name
        
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(selectBtn)
        
        constrain(imageView, selectBtn) { (img, btn) in
            img.top == img.superview!.top
            img.right == img.superview!.right
            img.left == img.superview!.left
            img.height == view.frame.height / 2 - 100
            
            btn.top == img.bottom + 20
            btn.right == img.superview!.right - 10
            btn.left == img.superview!.left + 10
            btn.height == 40
        }
    }
}
