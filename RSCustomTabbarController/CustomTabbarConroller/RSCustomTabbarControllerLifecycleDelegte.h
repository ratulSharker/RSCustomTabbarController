//
//  RSCustomTabbarLifecycleDelegte.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/26/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

#ifndef RSCustomTabbarLifecycleDelegte_h
#define RSCustomTabbarLifecycleDelegte_h

@class RSCustomTabbarControllerBasic;

@protocol RSCustomTabbarControllerLifecycleDelegte <NSObject>

//
//  These method's are optional method
//  as the viewController lifecycle (viewDidLoad, viewDidAppear, viewWillAppear) method
//  if none of them are specified, then it's okay, you won't get any error or crash for them
//  just like UIKit huh...
//


//
//  this function will whenever the view controller appeared.
//  if transition animation is implemented, then this method
//  will be called on the selectedViewController right after the
//  animation completed. If no animation provided, it will be called
//  just after placing everything in the right place. In either case
//  this method will be called after everything is done.
//
-(void)viewControllerDidAppearAnimationFinishedInTabbar:(RSCustomTabbarControllerBasic *)customTabbar;

@end



#endif /* RSCustomTabbarLifecycleDelegte_h */
