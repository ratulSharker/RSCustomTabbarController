//
//  AppDelegate.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 8/29/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

#import "RSCustomTabbarController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


//
// getting the currently showing tabbar controller
//
-(void)setCurrentCustomTabbarController:(RSCustomTabbarController*)tabbarController;
-(RSCustomTabbarController*)getCurrentCustomTabbarController;

//
//  getting the navigation controller
//
-(void)setCurrentNavigationController:(UINavigationController*)navigationController;
-(UINavigationController*)getCurrentNavigationController;


@end

