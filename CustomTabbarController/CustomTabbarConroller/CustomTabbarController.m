//
//  CustomTabbarController.m
//  CustomTabbarController
//
//  Created by Ratul Sharker on 8/29/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

#import "CustomTabbarController.h"

@implementation CustomTabbarController
{
    NSArray *viewControllers;
    NSInteger selectedIndex;
}


#pragma mark UIViewControllerLifeCycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    selectedIndex = 0;
    
    
    [self setSelectedViewCotnrollerAtIndex:selectedIndex];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(customTabbarControllerViewDidLoaded:)])
    {
        [self.delegate customTabbarControllerViewDidLoaded:self];
    }
}


#pragma mark public functionality
-(void)setViewControllers:(NSArray*)vcs
{
    viewControllers = vcs;
}
-(void)setSelectedViewCotnrollerAtIndex:(NSUInteger)index
{
    if(viewControllers && index < viewControllers.count /*&& index != selectedIndex*/)
    {
        
        //
        //  appropriate time for calling the tabbar
        //  button state update
        //
        [self.implementationDelegate newSelectedTabbarIndex:index whereOldIndexWas:selectedIndex];
        
        //it's valid index man
        selectedIndex = index;
        [self manageViewControllerToBeInFrontContainer:index];
    }
    else
    {
        NSLog(@"index is too much high to be set %d", selectedIndex);
    }
}
-(void)setTabbarVisibility:(BOOL)visible animated:(BOOL)animated
{
    //
    //  assume here tabbar default height never changing thing
    //
    
    if(visible)
    {
        CGFloat height = [self.implementationDelegate heightForTabbarController:self];
        for(NSLayoutConstraint *constraint in self.implementationDelegate.tabbarContainerHeight)
        {
            constraint.constant = visible * height;
        }
        
        for(NSLayoutConstraint *constraint in self.implementationDelegate.tabbarWidgetHolderTop)
        {
            constraint.active = visible;
        }
        
    }
    else
    {
        for(NSLayoutConstraint *constraint in self.implementationDelegate.tabbarWidgetHolderTop)
        {
            constraint.active = visible;
        }
        
        CGFloat height = [self.implementationDelegate heightForTabbarController:self];
        for(NSLayoutConstraint *constraint in self.implementationDelegate.tabbarContainerHeight)
        {
            constraint.constant = visible * height;
        }
    }

    
    //
    //
    //
    if(animated)
    {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        {
            [UIView animateWithDuration:0.5 animations:^{
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }];
        }
    }
}

-(UIViewController *)getViewControllerAtIndex:(NSUInteger)index
{
    if(viewControllers && index < viewControllers.count)
    {
        return [viewControllers objectAtIndex:index];
    }
    else
    {
        return nil;
    }
}
-(UIViewController *)getSelectedViewController
{
    return [self getViewControllerAtIndex:selectedIndex];
}
-(NSInteger)getSelectedIndex
{
    if(viewControllers)
    {
        return selectedIndex;
    }
    else
    {
        return -1;
    }
}

#pragma mark private functionality
-(void)manageViewControllerToBeInFrontContainer:(NSUInteger)index
{
    if(viewControllers && viewControllers.count > index)
    {
        UIViewController *targetViewController = viewControllers[index];
        
        NSLog(@"TARGET VIEWController bound %@", NSStringFromCGRect(targetViewController.view.frame));
        NSLog(@"CONTAINER BOUND %@", NSStringFromCGRect(self.implementationDelegate.viewControllerContainer.frame));
        NSLog(@"SELF.VIEW.BOUND %@", NSStringFromCGRect(self.view.frame));
        //  first of all check that is this viewController's view is in the
        //  container view
        if(targetViewController.parentViewController != self)
        {
            //  though at a time only one child viewcontroller
            //  will be in existence, but we should remove all
            //  for sake of generality
            for(UIViewController *childVC in self.childViewControllers)
            {
                [childVC willMoveToParentViewController:nil];
                [childVC.view removeFromSuperview];
                [childVC removeFromParentViewController];
            }
            
            
            //  now add the current view controller as the
            //  child view controller
            targetViewController.view.frame = self.implementationDelegate.viewControllerContainer.bounds;
            [self addChildViewController:targetViewController];
            [self.implementationDelegate.viewControllerContainer addSubview:targetViewController.view];
            [targetViewController didMoveToParentViewController:self];
        }
    }
    else
    {
        NSLog(@"TOO MUCH TAG VALUE IS SET, WHICH IS OUT OF THE NUMBE OF THE VIEWCONTROLLERS");
    }
}

@end