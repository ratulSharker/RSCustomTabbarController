//
//  Demo5TabbarController.swift
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/22/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

import Foundation

let TABBAR_SHOWN_SIZE = 160.0;
let TABBAR_HIDDEN_SIZE = 8.0;

@objc
class Demo5TabbarController: RSCustomTabbarController, RSCustomTabbarImplementationDelegate
{
    
//    @property UIView *viewControllerContainer;
//    
//    @property NSArray<NSLayoutConstraint*> *tabbarContainerHeight;
//    @property NSArray<NSLayoutConstraint*> *tabbarWidgetHolderTop;
//    
//    -(CGFloat)heightForTabbarController:(RSCustomTabbarController*)tabbarController;
//    -(void)newSelectedTabbarIndex:(NSUInteger)newSelectedIndex whereOldIndexWas:(NSUInteger)oldSelectedIndex;
    
    //
    // MARK:    RSCustomTabbarImplementationDelegate    properties
    //
    @IBOutlet var viewControllerContainer: UIView!

    //
    // MARK:    UI Components
    //
    @IBOutlet var tabbar0:  UIButton!;
    @IBOutlet var tabbar1:  UIButton!;
    @IBOutlet var tabbar2:  UIButton!;
    @IBOutlet var tabbar3:  UIButton!;
    
    @IBOutlet var mViewTabbarHolder: UIView!
    @IBOutlet var mViewTabbarHideShowBtn: UIButton!
    
    
    
    @IBOutlet var mConstraintTabHolderWidth: NSLayoutConstraint!
    
    
    var tabbars: [UIButton]!;
    
    

  
    
    //
    // MARK:    UIViewController Life-cycle method
    //
    override func viewDidLoad() {
        
        //  setup the tabbar first
        tabbars = [tabbar0, tabbar1, tabbar2, tabbar3];
        
        //  just fascinated ui things
        tabbar0.imageView?.contentMode = UIViewContentMode.ScaleAspectFit;
        tabbar1.imageView?.contentMode = UIViewContentMode.ScaleAspectFit;
        tabbar2.imageView?.contentMode = UIViewContentMode.ScaleAspectFit;
        tabbar3.imageView?.contentMode = UIViewContentMode.ScaleAspectFit;
        
        //  storing the index in the tag, so that we can access tabbars faster while handle button actions
        tabbar0.tag = 0;
        tabbar1.tag = 1;
        tabbar2.tag = 2;
        tabbar3.tag = 3;
        
        self.setTabbarVisibility(false, animated: false);
        mViewTabbarHideShowBtn.selected = true;
        
        //
        //  assigning the PopupTabbarTransitionAnimation as a animation handler
        //
        super.transitionAnimationDelegate = PopupTabbarTransitionAnimation();
        
        super.viewDidLoad();
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        self.navigationController?.navigationBarHidden = true;
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        
        self.navigationController?.navigationBarHidden = false;
    }
    
    
    //
    // MARK:    RSCustomTabbarController overidden method
    //
    override func setTabbarVisibility(visible: Bool, animated: Bool) {
        
        if(animated)
        {
            //  be aware need to perform some animation
            if(visible)
            {
                //need to show
                mViewTabbarHolder.alpha = 0.0;
                mViewTabbarHolder.hidden = false;
                UIView.animateWithDuration(0.5, animations: {
                    
                    self.mViewTabbarHolder.alpha = 1.0;
                    self.mConstraintTabHolderWidth.constant = CGFloat(TABBAR_SHOWN_SIZE);
                    
                    self.view.layoutIfNeeded();
                    
                    }, completion: { (completed) in
                });
            }
            else
            {
                //need to hide
                UIView.animateWithDuration(0.5, animations: { 
                    self.mViewTabbarHolder.alpha = 0.0;
                    self.mConstraintTabHolderWidth.constant = CGFloat(TABBAR_HIDDEN_SIZE);
                    
                    self.view.layoutIfNeeded();
                    
                    }, completion: { (completed) in
                        self.mViewTabbarHolder.hidden = true;
                        self.mViewTabbarHolder.alpha = 1.0;     //  restoring alpha
                        
                        
                })
            }
        }
        else
        {
            //  just hide or show, no animation needed
            if(visible)
            {
                //need to show
                mConstraintTabHolderWidth.constant = CGFloat(TABBAR_SHOWN_SIZE);
                mViewTabbarHolder.hidden = false;
            }
            else
            {
                //need to hide
                mConstraintTabHolderWidth.constant = CGFloat(TABBAR_HIDDEN_SIZE);
                mViewTabbarHolder.hidden = true;
            }
        }
        
    }
    
    
    //
    // MARK:    RSCustomTabbarImplementationDelegate method
    //
    
    func newSelectedTabbarIndex(newSelectedIndex: UInt,
                                whereOldIndexWas oldSelectedIndex: UInt) {
        
        if(newSelectedIndex == oldSelectedIndex)
        {
            //
            //  this is called for the first time
            //
            tabbars[Int(newSelectedIndex)].selected = true;
        }
        else
        {
            //
            //  subsequent call from user interaction
            //
            tabbars[Int(newSelectedIndex)].selected = true;
            tabbars[Int(oldSelectedIndex)].selected = false;
        }
    }
    
    //
    // MARK:    IBAction Methods
    //
    @IBAction func onTabbarButtonPressed(sender :UIButton!)
    {
        //
        //  this call will make the RSCustomTabbarController to 
        //  call the new select old select delegate called. 
        //  All the selection thing will be managed there.
        //
        super.setSelectedViewCotnrollerAtIndex(UInt(sender.tag));
    }
    
    @IBAction func onTabbarShowHidePressed(sender: UIButton!)
    {
        sender.selected = !sender.selected;
        
        if(sender.selected)
        {
            self.setTabbarVisibility(false, animated: true);
        }
        else
        {
            self.setTabbarVisibility(true, animated: true);
        }
    }
    
    
    
}