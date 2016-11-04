//
//  RSCustomTabbarController.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 8/29/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

#import "RSCustomTabbarTransitionAnimationDelegate.h"
#import "RSCustomTabbarImplementationDelegate.h"
#import "RSCustomTabbarDelegate.h"
#import "RSCustomTabbarControllerLifecycleDelegte.h"


@class RSCustomTabbarController;

//
//
//
typedef void (^RSCustomTabbarPendingBlock)();


//
//  specifying if none initial view controller is set
//  which view controller will be the initial,
//  here the index of the view controller is specified
//
#define CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX  0



@interface RSCustomTabbarController : UIViewController

@property id<RSCustomTabbarImplementationDelegate>        implementationDelegate;
@property id<RSCustomTabbarTransitionAnimationDelegate>   transitionAnimationDelegate;
@property id<RSCustomTabbarDelegate>                      delegate;


-(void)addPendingBlockIntendedToBeExecutedAfterViewDidLoad:(RSCustomTabbarGeneralPurposeBlock)block;
-(void)setShouldSelectDefaultViewController:(BOOL)shouldSelect;
-(void)setViewControllers:(NSArray*)vcs;
-(void)setSelectedViewCotnrollerAtIndex:(NSUInteger)index;
-(void)setTabbarVisibility:(BOOL)visible animated:(BOOL)animated;


-(void)removeViewControllerFromContainerAtIndex:(NSUInteger)index;
-(void)removeViewControllerFromContainer:(UIViewController*)viewController;
-(void)removeAllViewControllerFromContainer;


-(BOOL)isViewLoaded;
-(NSArray<UIViewController*>*)getViewControllers;
-(UIViewController *)getViewControllerAtIndex:(NSUInteger)index;
-(UIViewController *)getSelectedViewController;
-(NSInteger)getSelectedIndex;

-(CGRect)getViewControllerContainerFrame;
@end
