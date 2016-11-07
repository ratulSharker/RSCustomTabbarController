//
//  RSCustomTabbarImplementationDelegate.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/2/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#ifndef RSCustomTabbarImplementationDelegate_h
#define RSCustomTabbarImplementationDelegate_h

//
//  Forward declaration of the class,
//  to be used in the delegate method
//  param
//
@class RSCustomTabbarControllerBasic;


@protocol RSCustomTabbarImplementationDelegate <NSObject>

@required
@property UIView *viewControllerContainer;

@optional
@property NSArray<NSLayoutConstraint*> *tabbarContainerHeight;
@property NSArray<NSLayoutConstraint*> *tabbarWidgetHolderTop;
-(CGFloat)heightForTabbarController:(RSCustomTabbarControllerBasic*)tabbarController;

@required
-(void)newSelectedTabbarIndex:(NSUInteger)newSelectedIndex whereOldIndexWas:(NSUInteger)oldSelectedIndex;

@end

#endif /* RSCustomTabbarImplementationDelegate_h */
