//
//  RSCustomTabbarDelegate.h
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
