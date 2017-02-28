//
//  RSCustomTabbarControllerBasic.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 11/6/16.
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

#import <UIKit/UIKit.h>
#import "RSCustomTabbarTransitionAnimationDelegate.h"
#import "RSCustomTabbarImplementationDelegate.h"
#import "RSCustomTabbarDelegate.h"
#import "RSCustomTabbarControllerLifecycleDelegte.h"

//
//  specifying if none initial view controller is set
//  which view controller will be the initial,
//  here the index of the view controller is specified
//
#define CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX  0

#define DEFAULT_SELECTED_INDEX_WHILE_NOTHING_ON_CONTAINER   -1


@interface RSCustomTabbarControllerBasic : UIViewController
{
    NSArray<UIViewController*> *viewControllers;
    NSInteger selectedIndex;
}

@property id<RSCustomTabbarImplementationDelegate>        implementationDelegate;
@property id<RSCustomTabbarTransitionAnimationDelegate>   transitionAnimationDelegate;
@property id<RSCustomTabbarDelegate>                      delegate;


-(void)setShouldSelectDefaultViewController:(BOOL)shouldSelect;
-(void)setViewControllers:(NSArray*)vcs;
-(void)setSelectedViewCotnrollerAtIndex:(NSUInteger)index;
-(void)setTabbarVisibility:(BOOL)visible animated:(BOOL)animated;

-(UIViewController *)getViewControllerAtIndex:(NSUInteger)index;
-(UIViewController *)getSelectedViewController;
-(NSInteger)getSelectedIndex;

@end
