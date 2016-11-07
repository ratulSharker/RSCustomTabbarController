//
//  RSCustomTabbarDelegate.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/2/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#ifndef RSCustomTabbarDelegate_h
#define RSCustomTabbarDelegate_h

//
//  Forward declaration of the class,
//  to be used in the delegate method
//  param
//
@class RSCustomTabbarControllerBasic;

@protocol RSCustomTabbarDelegate <NSObject>
@optional

//
//  @return value will denote that, should the customTabbar show the default specified
//  view controller denoted by CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX or the delegate
//  will automatically select an view controller.
//
//  @discussion
//
//  If you select a view controller inside the delegate, you should return NO, so that,
//  viewDidLoad inside the RSCustomTabbarController won't try to show up the default
//  view controller denoted by the CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX.
//  Else should return YES, otherwise no view controller won't be present at front.
//  If this delegate is not implemented then, RSCustomTabbarController will load the
//  view controller denote by the CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX
//
- (void)customTabbarControllerViewDidLoaded:(RSCustomTabbarControllerBasic *)tabBarController;



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


#endif /* RSCustomTabbarDelegate_h */
