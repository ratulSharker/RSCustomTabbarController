//
//  PopupTabbarTransitionAnimation.swift
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/23/16.
//  Copyright © 2016 funtoos. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
// associated documentation files (the "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
// following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
// THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
    willSwitchFromIndex:
    willSwitchToIndex:
    withAnimationCompletionBlock:)
    
    func customTabbarController(tabbarController: RSCustomTabbarControllerBasic!, willSwitchFromIndex oldIndex: UInt, willSwitchToIndex newIndex: UInt, withAnimationCompletionBlock completionBlock: RSCustomTabbarGeneralPurposeBlock!) {

        //
        //  turning off all user interaction handling by app
        //  without these, unusual behaviour may appear
        //  while switching tab too fast
        //
        UIApplication.sharedApplication().beginIgnoringInteractionEvents();
        
        let tabbar = tabbarController as! RSCustomTabbarController;
        
        let toViewController = tabbarController.getViewControllerAtIndex(newIndex);
        
        toViewController.view.frame = tabbar.getViewControllerContainerFrame();
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
    
    func customTabbarController(tabbarController: RSCustomTabbarControllerBasic!, willRemoveViewControllers removingViewControllers: [UIViewController]!, withCompletionBlock completionBlock: RSCustomTabbarGeneralPurposeBlock!) {
        //
        //  we are not handling any dynamic tab deletion
        //  in case of any dynamic tab deletion, this protocol must be 
        //  implemented to get the desired effect
        //
    }
}