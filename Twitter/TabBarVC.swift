//
//  TabBarVC.swift
//  Twitter
//
//  Created by MacBook Pro on 12.06.16.
//  Copyright © 2016 Akhmed Idigov. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    
    
    // first load func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // color of item in tabbar controller
        self.tabBar.tintColor = .white

        // color of background of tabbar controller
        self.tabBar.barTintColor = colorBrandBlue
        
        // disable translucent
        self.tabBar.isTranslucent = false
        
        
        // color of text under icon in tabbar controller
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : colorSmoothGray], for: UIControlState())
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white], for: .selected)
        
        // new color for all icons of tabbar controller
        for item in self.tabBar.items! as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageColor(colorSmoothGray).withRenderingMode(.alwaysOriginal)
            }
        }
        
        
        // call animation of twitter
        twitterAnimation()
        
    }
    
    
    // Twitter Brand Animation
    func twitterAnimation() {
        
        // Blue layer
        let layer = UIView() // declare var of type UIView
        layer.frame = self.view.frame // declare size = same as screen's
        layer.backgroundColor = colorBrandBlue // color of view
        self.view.addSubview(layer) // add view to vc
        
        // Twitter icon
        let icon = UIImageView() // declare var of type uiimageView. Because it can store an image
        icon.image = UIImage(named: "twitter.png") // we refer to our image to be stored
        icon.frame.size.width = 100 // width of imageview
        icon.frame.size.height = 100 // height of imageview
        icon.center = view.center // center imageview as per screen size
        self.view.addSubview(icon) // imageview to vc
        
        // starting animation - zoom out bird
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveLinear, animations: { 
            
            // make small twitter
            icon.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
        }) { (finished:Bool) in
            
            // first func is finished
            if finished {
                
                // second animation - zoom in bird
                UIView.animate(withDuration: 0.5, animations: { 
                    
                    // make big twitter
                    icon.transform = CGAffineTransform(scaleX: 20, y: 20)
                    
                    // third animation - disapear bird
                    UIView.animate(withDuration: 0.1, delay: 0.3, options: .curveLinear, animations: { 
                        
                        // hide bird & layer
                        icon.alpha = 0
                        layer.alpha = 0
                        
                    }, completion: nil)
                    
                    
                })
                
            }
            
        }
        
        
        
    }
    
    
    
}


// new class we created to refer to our icon in tabbar controller.
extension UIImage {
    
    // in this func we customize our UIImage - our icon
    func imageColor(_ color : UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        
        color.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
