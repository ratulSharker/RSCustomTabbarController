//
//  RSCustomTabbarControllerBasic.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 11/6/16.
//  Copyright © 2016 funtoos. All rights reserved.
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
// associated documentation files (the "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
// following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
// THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import "RSCustomTabbarControllerBasic.h"

@interface RSCustomTabbarControllerBasic ()
{
    
    BOOL shouldLoadDefaultViewController;
}
@end

@implementation RSCustomTabbarControllerBasic

- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectedIndex = DEFAULT_SELECTED_INDEX_WHILE_NOTHING_ON_CONTAINER;
    
    if(shouldLoadDefaultViewController)
    {
        selectedIndex = CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX;
        [self setSelectedViewCotnrollerAtIndex:selectedIndex];
    }
    else
    {
        NSLog(@"default view controller is not loaded");
    }
    
    [self callDelegateViewDidLoadedWithTarget:self.delegate];
}




#pragma mark basic public functionality
-(void)setShouldSelectDefaultViewController:(BOOL)shouldSelect
{
    shouldLoadDefaultViewController = shouldSelect;
}

-(void)setViewControllers:(NSArray*)vcs
{
    viewControllers = vcs;
    
    selectedIndex = DEFAULT_SELECTED_INDEX_WHILE_NOTHING_ON_CONTAINER;
    
    //
    //  now lookup for the child view controller
    //  any of them are in viewcontorllers, if it is
    //  then update the currently selected according to
    //  that.
    //
    for(NSUInteger index = 0; index < viewControllers.count; index++)
    {
        if(viewControllers[index].parentViewController == self)
        {
            selectedIndex = index;
            break;
        }
    }
}

-(void)setSelectedViewCotnrollerAtIndex:(NSUInteger)index
{
    if(viewControllers && index < viewControllers.count /*&& index != selectedIndex*/)
    {
        
        if(selectedIndex == DEFAULT_SELECTED_INDEX_WHILE_NOTHING_ON_CONTAINER)
        {
            //
            //  first time experience
            //
            selectedIndex = index;
        }
        
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
    CGFloat height = [self.implementationDelegate heightForTabbarController:self];
    for(NSLayoutConstraint *constraint in self.implementationDelegate.tabbarContainerHeight)
    {
        constraint.constant = visible * height;
    }
    
    for(NSLayoutConstraint *constraint in self.implementationDelegate.tabbarWidgetHolderTop)
    {
        constraint.active = visible;
    }
    
    //
    // do the animation if needed to
    //
    if(animated)
    {
        [self animateConstraintChangesWithDuration:0.5];
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
    UIViewController *targetViewController = [self checkTheViewControllerAtIndexForManaging:index];
    
    if(targetViewController)
    {
        //
        //  adding the new view controller
        //
        [self addViewControllerAndView:targetViewController];
        
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
            
            //
            //  call the lifecycle viewControllerDidAppear
            //
            [self callViewControllerDidAppearAnimationFinishedIn:targetViewController];
            
        };
        
        
        //
        //  if transition animation exists, call it, otherwise call the completion block
        //
        if(![self callTransitionAnimationDelegateWillSwitchFrom:selectedIndex
                                                   willSwitchTo:index
                                            withCompletionBlock:completionBlock])
        {
            completionBlock();
        }
    }
    else
    {
        NSLog(@"TOO MUCH TAG VALUE IS SET, WHICH IS OUT OF THE NUMBE OF THE VIEWCONTROLLERS");
    }
}
-(UIViewController*)checkTheViewControllerAtIndexForManaging:(NSUInteger)index
{
    if(viewControllers && viewControllers.count > index)
    {
        //  first of all check that is this viewController's view is in the container view
        return (viewControllers[index].parentViewController == self) ? nil : viewControllers[index];
    }
    else
    {
        return nil;
    }
}

-(void)addViewControllerAndView:(UIViewController*)targetViewController
{
    [self addChildViewController:targetViewController];
    [self.implementationDelegate.viewControllerContainer addSubview:targetViewController.view];
    targetViewController.view.frame = self.implementationDelegate.viewControllerContainer.bounds;
    [targetViewController.view setNeedsLayout];
    [targetViewController.view layoutIfNeeded];
    [targetViewController didMoveToParentViewController:self];
}
-(BOOL)callTransitionAnimationDelegateWillSwitchFrom:(NSUInteger)oldIndex
                                        willSwitchTo:(NSUInteger)newIndex
                                 withCompletionBlock:(RSCustomTabbarGeneralPurposeBlock)completionBlock
{
    if(self.transitionAnimationDelegate &&
       [self.transitionAnimationDelegate respondsToSelector:@selector(customTabbarController:
                                                                      willSwitchFromIndex:
                                                                      willSwitchToIndex:
                                                                      withAnimationCompletionBlock:)])
    {
        [self.transitionAnimationDelegate customTabbarController:self
                                             willSwitchFromIndex:oldIndex
                                               willSwitchToIndex:newIndex
                                    withAnimationCompletionBlock:completionBlock];
        
        return YES;
    }
    else
    {
        return NO;
    }
}


-(void)callDelegateViewDidLoadedWithTarget:(id<RSCustomTabbarDelegate>)target
{
    if(target && [target respondsToSelector:@selector(customTabbarControllerViewDidLoaded:)])
    {
        [target customTabbarControllerViewDidLoaded:self];
    }
    else
    {
        NSLog(@"RSCustomTabbarController view did load delegate not implemented");
    }
}

-(void)callViewControllerDidAppearAnimationFinishedIn:(UIViewController*)targetViewController
{
    id<RSCustomTabbarControllerLifecycleDelegte> justAddedVC = (id<RSCustomTabbarControllerLifecycleDelegte>)targetViewController;
    
    if([justAddedVC respondsToSelector:@selector(viewControllerDidAppearAnimationFinishedInTabbar:)])
    {
        [justAddedVC viewControllerDidAppearAnimationFinishedInTabbar:self];
    }
    else
    {
        NSLog(@"LIFE Cycle callback not implemented");
    }
}

-(void)animateConstraintChangesWithDuration:(NSTimeInterval)timeInterval
{
    [UIView animateWithDuration:timeInterval
                     animations:^{
                         
        [self.view layoutIfNeeded];
                         
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}
@end
