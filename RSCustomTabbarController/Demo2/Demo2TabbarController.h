//
//  Demo2TabbarController.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 8/31/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "RSCustomTabbarController.h"

@interface Demo2TabbarController : RSCustomTabbarController <RSCustomTabbarImplementationDelegate>


#pragma mark CustomTabbarImplementationDelegate
@property IBOutlet UIView *viewControllerContainer;
@property IBOutletCollection (NSLayoutConstraint) NSArray   *tabbarContainerHeight;
@property IBOutletCollection(NSLayoutConstraint)  NSArray   *tabbarWidgetHolderTop;



@end
