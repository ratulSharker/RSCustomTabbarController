//
//  AppDelegate.h
//  CustomTabbarController
//
//  Created by Ratul Sharker on 8/29/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomTabbarController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


//
// getting the currently showing tabbar controller
//
-(void)setCurrentCustomTabbarController:(CustomTabbarController*)tabbarController;
-(CustomTabbarController*)getCurrentCustomTabbarController;

//
//  getting the navigation controller
//
-(void)setCurrentNavigationController:(UINavigationController*)navigationController;
-(UINavigationController*)getCurrentNavigationController;


@end

