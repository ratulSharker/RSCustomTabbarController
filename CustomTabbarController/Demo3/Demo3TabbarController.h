//
//  Demo3TabbarController.h
//  CustomTabbarController
//
//  Created by Ratul Sharker on 9/10/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

#import "CustomTabbarController.h"

@interface Demo3TabbarController : CustomTabbarController <CustomTabbarImplementationDelegate>



@property IBOutlet UIView *viewControllerContainer;

@property IBOutletCollection (NSLayoutConstraint) NSArray *tabbarContainerHeight;

@property IBOutletCollection (NSLayoutConstraint) NSArray *tabbarWidgetHolderTop;



@end
