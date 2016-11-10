//
//  RSCustomTabbarControllerBasic.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 11/6/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

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
