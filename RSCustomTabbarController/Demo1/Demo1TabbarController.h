//
//  Demo1TabbarController.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 8/29/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>
#import "RSCustomTabbarController.h"


@interface Demo1TabbarController : RSCustomTabbarController <RSCustomTabbarImplementationDelegate>


#pragma mark implementation properties
@property IBOutlet UIView *viewControllerContainer;
@property IBOutletCollection (NSLayoutConstraint) NSArray *tabbarContainerHeight;
@property IBOutletCollection (NSLayoutConstraint) NSArray *tabbarWidgetHolderTop;



@end

