//
//  JumpInTabbarTransitionAnimation.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 9/27/16.
//  Copyright © 2016 funtoos.
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
