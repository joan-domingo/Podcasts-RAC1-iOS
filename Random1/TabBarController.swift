//
//  TabBarController.swift
//  Random1
//
//  Created by Joan Domingo on 03.07.17.
//
//

import UIKit

class TabBarController: UITabBarController {
    
    init(tabs: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewControllers = tabs
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
