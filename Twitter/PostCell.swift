//
//  PostCell.swift
//  Twitter
//
//  Created by MacBook Pro on 13.06.16.
//  Copyright © 2016 Akhmed Idigov. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    // UI obj
    @IBOutlet var usernameLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var textLbl: UILabel!
    @IBOutlet var pictureImg: UIImageView!
    
    
    // first load func
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // color
        usernameLbl.textColor = colorBrandBlue
        
        // round corners
        pictureImg.layer.cornerRadius = pictureImg.bounds.width / 20
        pictureImg.clipsToBounds = true
    }

    
}