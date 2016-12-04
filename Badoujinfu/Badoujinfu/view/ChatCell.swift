//
//  chatCell.swift
//  Badoujinfu
//
//  Created by tietaowang on 16/5/17.
//  Copyright © 2016年 pierre. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell{
    

    @IBOutlet weak var topSpace: NSLayoutConstraint!
    
    @IBOutlet weak var chatInfo: UILabel!
    
    var    msgType = 0;
    
    @IBOutlet weak var mePortrailts: UIImageView!
    
    @IBOutlet weak var serverPortrailts: UIImageView!
    
}
