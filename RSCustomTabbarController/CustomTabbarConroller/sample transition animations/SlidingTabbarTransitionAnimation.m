//
//  SlidingTabbarTransitionAnimation.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 9/26/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "SlidingTabbarTransitionAnimation.h"

@implementation SlidingTabbarTransitionAnimation

-(void)customTabbarController:(RSCustomTabbarController *)tabbarController
   willSwitchToViewContorller:(UIViewController *)toViewController
           FromViewController:(NSMutableSet<UIViewController *> *)fromViewControllers
               withFinalFrame:(CGRect)finalFrame
             oldSelectedIndex:(NSUInteger)oldIndex
             newSelectedIndex:(NSUInteger)newIndex
 withAnimationCompletionBlock:(RSCustomTabbarGeneralPurposeBlock)completionBlock
{
    toViewController.view.alpha = 0.0;
    toViewController.view.frame = CGRectMake((newIndex > oldIndex) ? finalFrame.size.width : -finalFrame.size.width,
                                             finalFrame.origin.y,
                                             finalFrame.size.width,
                                             finalFrame.size.height);
    
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.3 animations:^{
       
        toViewController.view.frame = finalFrame;
        toViewController.view.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        if(completionBlock)
            completionBlock();
        
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}
@end
