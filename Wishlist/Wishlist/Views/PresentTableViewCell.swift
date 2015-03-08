//
//  PresentTableViewCell.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 09.10.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import UIKit

class PresentTableViewCell: UITableViewCell {
    
    
    @IBAction func search(sender: UIButton) {
sender.superview
        self.contentView.frame = CGRect(x: 0, y: 0, width: 320, height: 154)
        self.contentView.backgroundColor = UIColor.grayColor()
        self.reloadInputViews()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
