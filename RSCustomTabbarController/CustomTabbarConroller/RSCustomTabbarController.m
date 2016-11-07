//
//  RSCustomTabbarController.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 8/29/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "RSCustomTabbarController.h"



@interface RSCustomTabbarController()
{
    NSMutableArray<RSCustomTabbarGeneralPurposeBlock> *viewDidLoadPendingBlocks;
}

@end

@implementation RSCustomTabbarController


#pragma mark UIViewControllerLifeCycle
-(void)viewDidLoad
{
    [super viewDidLoad];
        
    //
    //  execute any pending block
    //
    if(viewDidLoadPendingBlocks && viewDidLoadPendingBlocks.count)
    {
        for(RSCustomTabbarGeneralPurposeBlock pendingBlock in viewDidLoadPendingBlocks)
        {
            pendingBlock();
        }
        
        [viewDidLoadPendingBlocks removeAllObjects];
    }
}


#pragma mark public functionality
-(void)addPendingBlockIntendedToBeExecutedAfterViewDidLoad:(RSCustomTabbarGeneralPurposeBlock)block
{
    if(!viewDidLoadPendingBlocks)
    {
        //
        //  tracker is not initiated yet, but want to track.
        //  so it's high time to initiate it
        //
        viewDidLoadPendingBlocks = [[NSMutableArray alloc] init];
    }
    
    //
    //  now we got initiated tracker :D ,
    //  just track the pending blocks
    //
    [viewDidLoadPendingBlocks addObject:block];
}







-(void)removeViewControllerFromContainerAtIndex:(NSUInteger)index
{
    //
    //  check that the index is valid or not
    //
    if(viewControllers && viewControllers.count > index)
    {
        [self removeViewControllerFromContainer:viewControllers[index]];
    }
    else
    {
        NSLog(@"index is too high, in removeViewControllerFromContainerAtIndex");
    }
}
-(void)removeViewControllerFromContainer:(UIViewController*)viewController
{
    if(viewController && viewController.parentViewController == self)
    {
        RSCustomTabbarGeneralPurposeBlock completionBlock = ^{
            [viewController willMoveToParentViewController:nil];
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
            selectedIndex = DEFAULT_SELECTED_INDEX_WHILE_NOTHING_ON_CONTAINER;
        };
        
        if(![self callTranstionAnimationDelegateWillRemoveViewController:@[viewController]
                                                     withCompletionBlock:completionBlock])
        {
            completionBlock();
        }

    }
    else
    {
        NSLog(@"view controller is not valid or does not belong to this tab container");
    }
}

-(void)removeAllViewControllerFromContainer
{
    
    RSCustomTabbarGeneralPurposeBlock completionBlock = ^{
        //  though at a time only one child viewcontroller
        //  will be in existence, but we should remove all
        //  for sake of generality
        for(UIViewController *childVC in self.childViewControllers)
        {
            [childVC willMoveToParentViewController:nil];
            [childVC.view removeFromSuperview];
            [childVC removeFromParentViewController];
        }
        selectedIndex = DEFAULT_SELECTED_INDEX_WHILE_NOTHING_ON_CONTAINER;
    };
    

    if(![self callTranstionAnimationDelegateWillRemoveViewController:self.childViewControllers
                                                 withCompletionBlock:completionBlock])
    {
        completionBlock();
    }
}

-(BOOL)isViewLoaded
{
    return super.isViewLoaded;
}






-(CGRect)getViewControllerContainerFrame
{
    CGRect frame = CGRectZero;
    
    if(self.implementationDelegate && self.implementationDelegate.viewControllerContainer)
    {
        frame = self.implementationDelegate.viewControllerContainer.bounds;
    }
    
    return frame;
}

#pragma mark private helper method
-(BOOL)callTranstionAnimationDelegateWillRemoveViewController:(NSArray<UIViewController*>*)vcs
                                          withCompletionBlock:(RSCustomTabbarGeneralPurposeBlock)completionBlock
{
    if(self.transitionAnimationDelegate &&
       [self.transitionAnimationDelegate respondsToSelector:@selector(customTabbarController:
                                                                      willRemoveViewControllers:
                                                                      withCompletionBlock:)])
    {
        [self.transitionAnimationDelegate customTabbarController:self
                                       willRemoveViewControllers:vcs
                                             withCompletionBlock:completionBlock];
        
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
