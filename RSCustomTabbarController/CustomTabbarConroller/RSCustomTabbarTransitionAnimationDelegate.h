//
//  RSCustomTabbarTransitionAnimationDelegate.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/2/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#ifndef RSCustomTabbarTransitionAnimationDelegate_h
#define RSCustomTabbarTransitionAnimationDelegate_h

#import <UIKit/UIKit.h>

//
//  Forward declaration of the class,
//  to be used in the delegate method
//  param
//
@class RSCustomTabbarController;

//
//  Declaration of the code block type
//  to be used in the delegate method
//  param
//
typedef void (^RSCustomTabbarGeneralPurposeBlock)();

@protocol RSCustomTabbarTransitionAnimationDelegate<NSObject>

-(void)customTabbarController:(RSCustomTabbarController*)tabbarController
          willSwitchFromIndex:(NSUInteger)oldIndex
            willSwitchToIndex:(NSUInteger)newIndex
 withAnimationCompletionBlock:(RSCustomTabbarGeneralPurposeBlock)completionBlock;

//
//  TODO :  another animation delegate needed to be added,
//  in case of removing view controller from the container
//
-(void)customTabbarController:(RSCustomTabbarController*)tabbarController
    willRemoveViewControllers:(NSArray<UIViewController*>*)removingViewControllers
          withCompletionBlock:(RSCustomTabbarGeneralPurposeBlock)completionBlock;

@end


#endif /* RSCustomTabbarTransitionAnimationDelegate_h */
