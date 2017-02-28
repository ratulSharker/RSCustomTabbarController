//
//  RSCustomTabbarTransitionAnimationDelegate.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/2/16.
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

#ifndef RSCustomTabbarTransitionAnimationDelegate_h
#define RSCustomTabbarTransitionAnimationDelegate_h

#import <UIKit/UIKit.h>

//
//  Forward declaration of the class,
//  to be used in the delegate method
//  param
//
@class RSCustomTabbarControllerBasic;

//
//  Declaration of the code block type
//  to be used in the delegate method
//  param
//
typedef void (^RSCustomTabbarGeneralPurposeBlock)();

@protocol RSCustomTabbarTransitionAnimationDelegate<NSObject>

-(void)customTabbarController:(RSCustomTabbarControllerBasic*)tabbarController
          willSwitchFromIndex:(NSUInteger)oldIndex
            willSwitchToIndex:(NSUInteger)newIndex
 withAnimationCompletionBlock:(RSCustomTabbarGeneralPurposeBlock)completionBlock;

//
//  TODO :  another animation delegate needed to be added,
//  in case of removing view controller from the container
//
-(void)customTabbarController:(RSCustomTabbarControllerBasic*)tabbarController
    willRemoveViewControllers:(NSArray<UIViewController*>*)removingViewControllers
          withCompletionBlock:(RSCustomTabbarGeneralPurposeBlock)completionBlock;

@end


#endif /* RSCustomTabbarTransitionAnimationDelegate_h */
