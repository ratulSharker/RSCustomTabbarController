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


//  not yet implemented
//
//  used for event based functionality
//
@protocol CustomTabbarDelegate <NSObject>
@optional

//- (BOOL)customTabbarController:(CustomTabbarController *)tabBarController
//    willSelectViewController:(UIViewController *)viewController;
//
//- (void)customTabbarController:(CustomTabbarController *)tabBarController
//       didSelectViewController:(UIViewController *)viewController;

- (void)customTabbarControllerViewDidLoaded:(CustomTabbarController *)tabBarController;



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

@property id<CustomTabbarImplementationDelegate>    implementationDelegate;
@property id<CustomTabbarDelegate>                  delegate;

-(void)setViewControllers:(NSArray*)vcs;
-(void)setSelectedViewCotnrollerAtIndex:(NSUInteger)index;
-(void)setTabbarVisibility:(BOOL)visible animated:(BOOL)animated;

-(UIViewController *)getViewControllerAtIndex:(NSUInteger)index;
-(UIViewController *)getSelectedViewController;
-(NSInteger)getSelectedIndex;
@end
