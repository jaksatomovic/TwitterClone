//
//  UsersCell.swift
//  Twitter
//
//  Created by MacBook Pro on 14.06.16.
//  Copyright © 2016 Akhmed Idigov. All rights reserved.
//

import UIKit

class UsersCell: UITableViewCell {

    // UI obj
    @IBOutlet var avaImg: UIImageView!
    @IBOutlet var usernameLbl: UILabel!
    @IBOutlet var fullnameLbl: UILabel!
    
    
    // first load func
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // round corners
        avaImg.layer.cornerRadius = avaImg.bounds.width / 2
        avaImg.clipsToBounds = true
        
        // color
        usernameLbl.textColor = colorBrandBlue
        
    }
    
    
}