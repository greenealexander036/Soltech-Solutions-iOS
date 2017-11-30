//
//  HomeOption.swift
//  Soltech-Solutions
//
//  Created by Alexander Greene on 9/24/17.
//  Copyright © 2017 Alexander Greene. All rights reserved.
//

import UIKit

class NavOption {
    var title: String!
    var backgroundImageName: String!
    var viewControllerType: UIViewController.Type!
    
    init(title: String, backgroundImageName: String, viewControllerType: UIViewController.Type) {
        self.title = title
        self.backgroundImageName = backgroundImageName
        self.viewControllerType = viewControllerType
    }
}
