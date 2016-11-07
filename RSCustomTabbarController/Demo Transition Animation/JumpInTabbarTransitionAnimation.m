//
//  JumpInTabbarTransitionAnimation.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 9/27/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JumpInTabbarTransitionAnimation.h"
#import "RSCustomTabbarController.h"

@implementation JumpInTabbarTransitionAnimation


-(void)customTabbarController:(RSCustomTabbarControllerBasic *)tabbarController
          willSwitchFromIndex:(NSUInteger)oldIndex
            willSwitchToIndex:(NSUInteger)newIndex
 withAnimationCompletionBlock:(RSCustomTabbarGeneralPurposeBlock)completionBlock
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    UIViewController *toViewController = [tabbarController getViewControllerAtIndex:newIndex];
    CGRect finalFrame = [(RSCustomTabbarController*)tabbarController getViewControllerContainerFrame];
    
    toViewController.view.alpha = 0.0;
    toViewController.view.frame = finalFrame;
    toViewController.view.center = [self getCenterPointOfRect:finalFrame accordingtoIndex:newIndex];

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

#pragma mark private helper method
-(CGPoint)getCenterPointOfRect:(CGRect)frame accordingtoIndex:(NSUInteger)index
{
    CGPoint center;
    
    switch (index) {
        case 0:
        {
            center = CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame));
        }
            break;
        case 1:
        {
            center = CGPointMake(CGRectGetMaxX(frame), CGRectGetMinY(frame));
        }
            break;
        case 2:
        {
            center = CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame));
        }
            break;
        case 3:
        {
            center = CGPointMake(CGRectGetMinX(frame), CGRectGetMaxY(frame));
        }
            break;
            
        default:
            center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
            break;
    }
    
    return center;
}
@end
