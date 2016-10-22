//
//  Demo5TabbarController.swift
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/22/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

import Foundation

//
//

@objc
class Demo5TabbarController: RSCustomTabbarController
{
    
//    @property UIView *viewControllerContainer;
//    
//    @property NSArray<NSLayoutConstraint*> *tabbarContainerHeight;
//    @property NSArray<NSLayoutConstraint*> *tabbarWidgetHolderTop;
//    
//    -(CGFloat)heightForTabbarController:(RSCustomTabbarController*)tabbarController;
//    -(void)newSelectedTabbarIndex:(NSUInteger)newSelectedIndex whereOldIndexWas:(NSUInteger)oldSelectedIndex;
    
//
// MARK:    RSCustomTabbarImplementationDelegate
//
    @IBOutlet var viewControllerContainer: UIView!
  
    
//
// MARK:    UIViewController Life-cycle method
//
    override func viewDidLoad() {
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        self.navigationController?.navigationBarHidden = true;
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        
        self.navigationController?.navigationBarHidden = false;
    }
}