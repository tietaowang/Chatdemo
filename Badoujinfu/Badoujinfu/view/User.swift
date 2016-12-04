//
//  User.swift
//  Badoujinfu
//
//  Created by pierre on 16/5/18.
//  Copyright © 2016年 pierre. All rights reserved.
//

import Foundation

class User: NSObject {
    
    var name:String!;
    var account:String!
    
     init(name:String,account:String) {
        
        self.name = name;
        self.account = account;
        super.init()
    }
    
    
    
    
    
}
