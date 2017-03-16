//
//  NavVC.swift
//  Twitter
//
//  Created by MacBook Pro on 12.06.16.
//  Copyright © 2016 Akhmed Idigov. All rights reserved.
//

import UIKit

class NavVC: UINavigationController {

    
    // first load func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // color of title at the top of nav controller
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        // color of buttons in nav controller
        self.navigationBar.tintColor = .white
        
        // color of background of nav controller / nav bar
        self.navigationBar.barTintColor = colorBrandBlue
        
        // disable translucent
        self.navigationBar.isTranslucent = false
        
    }
    
    
    // white status bar
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
}
