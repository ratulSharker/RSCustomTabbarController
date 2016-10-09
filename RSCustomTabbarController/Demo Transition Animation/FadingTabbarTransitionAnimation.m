//
//  FadingTabbarTransitionAnimation.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 9/23/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "FadingTabbarTransitionAnimation.h"

@implementation FadingTabbarTransitionAnimation

-(void)customTabbarController:(RSCustomTabbarController*)tabbarController
   willSwitchToViewContorller:(UIViewController*)toViewController
           FromViewController:(NSMutableSet<UIViewController*>*)fromViewControllers
               withFinalFrame:(CGRect)finalFrame
             oldSelectedIndex:(NSUInteger)oldIndex
             newSelectedIndex:(NSUInteger)newIndex
 withAnimationCompletionBlock:(RSCustomTabbarGeneralPurposeBlock)completionBlock
{
    toViewController.view.alpha = 0.0;
    toViewController.view.frame = finalFrame;
    
    for(UIViewController *fromViewController in fromViewControllers)
        fromViewController.view.alpha = 1.0;
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [UIView animateWithDuration:0.6 animations:^{
        
        toViewController.view.alpha = 1.0;
        for(UIViewController *fromViewController in fromViewControllers)
            fromViewController.view.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        for(UIViewController *fromViewController in fromViewControllers)
            fromViewController.view.alpha = 1.0;

        if(completionBlock)
            completionBlock();
        
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}

-(void)customTabbarController:(RSCustomTabbarController*)tabbarController
    willRemoveViewControllers:(NSArray<UIViewController*>*)removingViewControllers
          withCompletionBlock:(RSCustomTabbarGeneralPurposeBlock)completionBlock
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [UIView animateWithDuration:0.6 animations:^{
        
        for(UIViewController *removingViewController in removingViewControllers)
            removingViewController.view.alpha = 0.0;
    
    } completion:^(BOOL finished) {
        if(completionBlock)
            completionBlock();
        
        for(UIViewController *removingViewController in removingViewControllers)
            removingViewController.view.alpha = 0.0;
        
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}


@end
