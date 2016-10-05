//
//  RSCustomTabbarController.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 8/29/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "RSCustomTabbarController.h"

@implementation RSCustomTabbarController
{
    NSArray *viewControllers;
    NSInteger selectedIndex;
}


#pragma mark UIViewControllerLifeCycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(customTabbarControllerViewDidLoaded:)])
    {
        BOOL shouldLoadDefault = [self.delegate customTabbarControllerViewDidLoaded:self];
        
        if(shouldLoadDefault)
        {
            selectedIndex = CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX;
            [self setSelectedViewCotnrollerAtIndex:selectedIndex];
        }
    }
    else
    {
        //  RSCustomTabbarControllerViewDidLoaded delegate is not
        //  implemented, so we will load the default view controller
        selectedIndex = CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX;
        [self setSelectedViewCotnrollerAtIndex:selectedIndex];
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
        
        
        [self manageViewControllerToBeInFrontContainer:index];
    }
    else
    {
        NSLog(@"index is too much high to be set %ld", (long)selectedIndex);
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
            
            //
            //  adding the new view controller
            //
            [self addChildViewController:targetViewController];
            [self.implementationDelegate.viewControllerContainer addSubview:targetViewController.view];
            targetViewController.view.frame = self.implementationDelegate.viewControllerContainer.bounds;
            [targetViewController.view setNeedsLayout];
            [targetViewController.view layoutIfNeeded];
            [targetViewController didMoveToParentViewController:self];
            
            NSMutableSet <UIViewController*> *previousViewControllers = [[NSMutableSet alloc] initWithArray:self.childViewControllers];
            [previousViewControllers removeObject:targetViewController];
            
            //
            //  forming the completion block
            //
            RSCustomTabbarGeneralPurposeBlock completionBlock = ^{
                //  though at a time only one child viewcontroller
                //  will be in existence, but we should remove all
                //  for sake of generality
                for(UIViewController *childVC in previousViewControllers)
                {
                    [childVC willMoveToParentViewController:nil];
                    [childVC.view removeFromSuperview];
                    [childVC removeFromParentViewController];
                }
                
                //
                //  store the new selected index, for later use and consistency
                //
                selectedIndex = index;
                
                //
                //  for surity
                //
                targetViewController.view.frame = self.implementationDelegate.viewControllerContainer.bounds;
                
            };
            
            if(self.transitionAnimationDelegate &&
               [self.transitionAnimationDelegate respondsToSelector:@selector(customTabbarController:
                                                                              willSwitchToViewContorller:
                                                                              FromViewController:
                                                                              withFinalFrame:
                                                                              oldSelectedIndex:
                                                                              newSelectedIndex:
                                                                              withAnimationCompletionBlock:)])
            {

                
                [self.transitionAnimationDelegate customTabbarController:self
                                              willSwitchToViewContorller:targetViewController
                                                      FromViewController:previousViewControllers
                                                          withFinalFrame:self.implementationDelegate.viewControllerContainer.bounds
                                                        oldSelectedIndex:selectedIndex
                                                        newSelectedIndex:index
                                            withAnimationCompletionBlock:completionBlock];
            }
            else
            {
                completionBlock();
            }
            

        }
    }
    else
    {
        NSLog(@"TOO MUCH TAG VALUE IS SET, WHICH IS OUT OF THE NUMBE OF THE VIEWCONTROLLERS");
    }
}

@end
