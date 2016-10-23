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
    // MARK: pre loaded values
    //
    var VCBackgroundColor:  UIColor!;
    var VCTitleString:      String!;
    
    
    //
    // MARK: ui components
    //
    @IBOutlet var mViewLabel: UILabel!
    
    
    //
    // MARK: Life cycle Method
    //
    override func viewDidLoad() {
        super.viewDidLoad();
        
        mViewLabel.text = VCTitleString;
        self.view.backgroundColor = VCBackgroundColor;
    }
    
    
    @IBAction func backToDemoList(sender : UIButton)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        let currentNavigation = appDelegate.getCurrentNavigationController();
        currentNavigation.popViewControllerAnimated(true);
    }
}