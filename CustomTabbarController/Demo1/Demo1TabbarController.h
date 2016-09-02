//
//  Demo1TabbarController.h
//  CustomTabbarController
//
//  Created by Ratul Sharker on 8/29/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabbarController.h"


@interface Demo1TabbarController : CustomTabbarController <CustomTabbarImplementationDelegate>


#pragma mark implementation properties
@property IBOutlet UIView *viewControllerContainer;
@property IBOutletCollection (NSLayoutConstraint) NSArray *tabbarContainerHeight;
@property IBOutletCollection (NSLayoutConstraint) NSArray *tabbarWidgetHolderTop;



@end

