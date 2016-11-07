//
//  RSCustomTabbarController.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 8/29/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>
#import "RSCustomTabbarControllerBasic.h"

//
//
//
typedef void (^RSCustomTabbarPendingBlock)();


@interface RSCustomTabbarController : RSCustomTabbarControllerBasic

-(void)addPendingBlockIntendedToBeExecutedAfterViewDidLoad:(RSCustomTabbarGeneralPurposeBlock)block;

-(void)removeViewControllerFromContainerAtIndex:(NSUInteger)index;
-(void)removeViewControllerFromContainer:(UIViewController*)viewController;
-(void)removeAllViewControllerFromContainer;


-(BOOL)isViewLoaded;
-(CGRect)getViewControllerContainerFrame;

@end
