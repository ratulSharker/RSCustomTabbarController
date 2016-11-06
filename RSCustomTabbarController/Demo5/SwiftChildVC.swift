//
//  SwiftChildVC.swift
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/23/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

import Foundation

class SwiftChildVC : UIViewController
{
    //
    // MARK: ui components
    //
    @IBOutlet var mViewLabel: UILabel!
    
    
    //
    // MARK: Life cycle Method
    //
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    
    @IBAction func backToDemoList(sender : UIButton)
    {
        AppDelegate.moveToMenuTableViewController();
    }
}