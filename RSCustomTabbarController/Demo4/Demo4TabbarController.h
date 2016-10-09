//
//  Demo4TabbarController.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/8/16.
//  Copyright © 2016 funtoos. All rights reserved.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "RSCustomTabbarController.h"






@interface Demo4TabbarController : RSCustomTabbarController <RSCustomTabbarImplementationDelegate>

@property IBOutlet UIView *viewControllerContainer;

@property IBOutletCollection(NSLayoutConstraint)  NSArray *tabbarContainerHeight;
@property IBOutletCollection(NSLayoutConstraint)  NSArray *tabbarWidgetHolderTop;



@end
