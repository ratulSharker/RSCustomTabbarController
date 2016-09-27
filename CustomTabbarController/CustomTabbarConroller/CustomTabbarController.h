//
//  CustomTabbarController.h
//  CustomTabbarController
//
//  Created by Ratul Sharker on 8/29/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabbarController;

//
//  specifying if none initial view controller is set
//  which view controller will be the initial,
//  here the index of the view controller is specified
//
#define CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX  0

typedef void (^CustomTabbarGeneralPurposeBlock)();

//
//  used for functionality
//
@protocol CustomTabbarImplementationDelegate <NSObject>

@required
@property UIView *viewControllerContainer;

@property NSArray<NSLayoutConstraint*> *tabbarContainerHeight;
@property NSArray<NSLayoutConstraint*> *tabbarWidgetHolderTop;

-(CGFloat)heightForTabbarController:(CustomTabbarController*)tabbarController;
-(void)newSelectedTabbarIndex:(NSUInteger)newSelectedIndex whereOldIndexWas:(NSUInteger)oldSelectedIndex;

@end


@protocol CustomTabbarTransitionAnimationDelegate<NSObject>

-(void)customTabbarController:(CustomTabbarController*)tabbarController
   willSwitchToViewContorller:(UIViewController*)toViewController
           FromViewController:(NSMutableSet<UIViewController*>*)fromViewControllers
               withFinalFrame:(CGRect)finalFrame
             oldSelectedIndex:(NSUInteger)oldIndex
             newSelectedIndex:(NSUInteger)newIndex
          withAnimationCompletionBlock:(CustomTabbarGeneralPurposeBlock)completionBlock;

@end


//  not yet implemented
//
//  used for event based functionality
//
@protocol CustomTabbarDelegate <NSObject>
@optional

//
//  @return value will denote that, should the customTabbar show the default specified
//  view controller denoted by CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX or the delegate
//  will automatically select an view controller.
//
//  @discussion
//
//  If you select a view controller inside the delegate, you should return NO, so that,
//  viewDidLoad inside the CustomTabbarController won't try to show up the default
//  view controller denoted by the CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX.
//  Else should return YES, otherwise no view controller won't be present at front.
//  If this delegate is not implemented then, CustomTabbarController will load the
//  view controller denote by the CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX
//
- (BOOL)customTabbarControllerViewDidLoaded:(CustomTabbarController *)tabBarController;



#pragma mark Unimplemented delegate methods
//- (BOOL)customTabbarController:(CustomTabbarController *)tabBarController
//    willSelectViewController:(UIViewController *)viewController;
//
//- (void)customTabbarController:(CustomTabbarController *)tabBarController
//       didSelectViewController:(UIViewController *)viewController;

//- (void)customTabBarController:(CustomTabbarController *)tabBarController
//willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;

//- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;

//- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed __TVOS_PROHIBITED;

//- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;
//- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;
//- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController NS_AVAILABLE_IOS(7_0);
//
//- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
//                                                       toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);

@end


@interface CustomTabbarController : UIViewController

@property id<CustomTabbarImplementationDelegate>        implementationDelegate;
@property id<CustomTabbarTransitionAnimationDelegate>   transitionAnimationDelegate;
@property id<CustomTabbarDelegate>                      delegate;

-(void)setViewControllers:(NSArray*)vcs;
-(void)setSelectedViewCotnrollerAtIndex:(NSUInteger)index;
-(void)setTabbarVisibility:(BOOL)visible animated:(BOOL)animated;

-(UIViewController *)getViewControllerAtIndex:(NSUInteger)index;
-(UIViewController *)getSelectedViewController;
-(NSInteger)getSelectedIndex;
@end
