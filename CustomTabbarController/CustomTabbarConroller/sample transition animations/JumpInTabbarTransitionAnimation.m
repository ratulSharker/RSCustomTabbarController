//
//  JumpInTabbarTransitionAnimation.m
//  CustomTabbarController
//
//  Created by Ratul Sharker on 9/27/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

#import "JumpInTabbarTransitionAnimation.h"


@implementation JumpInTabbarTransitionAnimation


-(void)customTabbarController:(CustomTabbarController*)tabbarController
   willSwitchToViewContorller:(UIViewController*)toViewController
           FromViewController:(NSMutableSet<UIViewController*>*)fromViewControllers
               withFinalFrame:(CGRect)finalFrame
             oldSelectedIndex:(NSUInteger)oldIndex
             newSelectedIndex:(NSUInteger)newIndex
 withAnimationCompletionBlock:(CustomTabbarGeneralPurposeBlock)completionBlock
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    toViewController.view.alpha = 0.0;
    toViewController.view.frame = finalFrame;
    
    switch (newIndex) {
        case 0:
        {
            toViewController.view.center = CGPointMake(CGRectGetMinX(finalFrame), CGRectGetMinY(finalFrame));
        }
            break;
        case 1:
        {
            toViewController.view.center = CGPointMake(CGRectGetMaxX(finalFrame), CGRectGetMinY(finalFrame));
        }
            break;
        case 2:
        {
            toViewController.view.center = CGPointMake(CGRectGetMaxX(finalFrame), CGRectGetMaxY(finalFrame));
        }
            break;
        case 3:
        {
            toViewController.view.center = CGPointMake(CGRectGetMinX(finalFrame), CGRectGetMaxY(finalFrame));
        }
            break;
            
        default:
            toViewController.view.center = CGPointMake(CGRectGetMidX(finalFrame), CGRectGetMidY(finalFrame));
            break;
    }

    
    [toViewController.view layoutIfNeeded];
    
    
    CALayer *viewLayer = toViewController.view.layer;
    viewLayer.transform = CATransform3DMakeScale(0, 0, 1);
    
    
    [UIView animateWithDuration:0.4 animations:^{
        viewLayer.transform = CATransform3DIdentity;
        toViewController.view.center = CGPointMake(CGRectGetMidX(finalFrame), CGRectGetMidY(finalFrame));
        toViewController.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        
        if(completionBlock)
            completionBlock();
        
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}
@end
