//
//  HomeViewController.swift
//  Badoujinfu
//
//  Created by pierre on 16/5/13.
//  Copyright © 2016年 pierre. All rights reserved.
//
import UIKit

class HomeViewController : UIViewController  {
    
    
    @IBOutlet weak var roundView: UIView!
    
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        login.layer.cornerRadius = 10;
        
        
        
      
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
}
