//
//  PopupTabbarTransitionAnimation.swift
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/23/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

import Foundation

//
//  for some wierd reason, all sort of objective-c protocol are not
//  directly compatible to be implemented vai swift, here i have to introduce
//  an objective-c mapping. I have came upon this solution from following
//  
//  http://stackoverflow.com/questions/31832147/swift-class-does-not-conform-to-objective-c-protocol-with-error-handling
//


class PopupTabbarTransitionAnimation : NSObject, RSCustomTabbarTransitionAnimationDelegate
{
    
    //
    // MARK: objective-c mapping for the following method implementation
    //
    @objc(customTabbarController:
    withFinalFrame:
    oldSelectedIndex:
    newSelectedIndex:
    withAnimationCompletionBlock:)
    
    func customTabbarController(tabbarController: RSCustomTabbarController!, withFinalFrame finalFrame: CGRect, oldSelectedIndex oldIndex: UInt, newSelectedIndex newIndex: UInt, withAnimationCompletionBlock completionBlock: RSCustomTabbarGeneralPurposeBlock!) {

        //
        //  turning off all user interaction handling by app
        //  without these, unusual behaviour may appear
        //  while switching tab too fast
        //
        UIApplication.sharedApplication().beginIgnoringInteractionEvents();
        
        let toViewController = tabbarController.getViewControllerAtIndex(newIndex);
        

        toViewController.view.frame = finalFrame;
        toViewController.view.layer.transform = CATransform3DMakeScale(0, 0, 0);
        
        UIView.animateWithDuration(0.5, animations: { 
            
            //
            // do the animation here
            //
            toViewController.view.layer.transform = CATransform3DIdentity;
            
            
            }) { (completed) in
            
                //
                //  animation completed do the completion stuff
                //
                completionBlock();
                
                //
                //  all the task are done, we should enable user interaction
                //
                UIApplication.sharedApplication().endIgnoringInteractionEvents();
        };
    }
    
    
    //
    // MARK: objective-c mapping for the following method
    //
    @objc(customTabbarController:
    willRemoveViewControllers:
    withCompletionBlock:)
    
    func customTabbarController(tabbarController: RSCustomTabbarController!, willRemoveViewControllers removingViewControllers: [UIViewController]!, withCompletionBlock completionBlock: RSCustomTabbarGeneralPurposeBlock!) {
        //
        //  we are not handling any dynamic tab deletion
        //  in case of any dynamic tab deletion, this protocol must be 
        //  implemented to get the desired effect
        //
    }
}