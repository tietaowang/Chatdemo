//
//  ViewController.swift
//  Badoujinfu
//
//  Created by pierre on 16/5/6.
//  Copyright © 2016年 pierre. All rights reserved.
//

import UIKit


class ViewController: UIViewController,AsyncSocketDelegate {

    @IBOutlet weak var accountField: UITextField!
    var socket:AsyncSocket? ;
    
    @IBOutlet weak var nameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
       var  vc =   segue.destinationViewController  as! ChatViewController
       
        vc.user = User.init(name:  self.nameField.text!, account: self.accountField.text!)
        
        print(vc)
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
       4
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  }

