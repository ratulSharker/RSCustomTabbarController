//
//  Demo6TabbarControllerViewController.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 1/31/17.
//  Copyright © 2017 funtoos. All rights reserved.
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

#import "Demo6TabbarControllerViewController.h"
#import "Demo6TabbarItemCell.h"

@interface Demo6TabbarControllerViewController () < UICollectionViewDataSource,
                                                    UICollectionViewDelegate,
                                                    UIGestureRecognizerDelegate>
{
    //
    //  this things may be supplied from outside
    //
    NSArray<NSDictionary*>  *tabbarItems;
    
    //
    //  view components
    //
    IBOutlet UICollectionView *mViewTabbarCollectionView;
    
    //
    //  gesture components
    //
    UIPanGestureRecognizer *sliderPanGesture;
    
    //
    //  moving bottom layer inside collection view
    //
    CALayer *collectionViewBottomLayer;
}
@end

@implementation Demo6TabbarControllerViewController

- (void)viewDidLoad {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    tabbarItems = @[
                    @{
                        TABBAR_ITEM_TEXT_KEY    :   @"Item 1"
                        },
                    @{
                        TABBAR_ITEM_TEXT_KEY    :   @"Item 2"
                        },
                    @{
                        TABBAR_ITEM_TEXT_KEY    :   @"Item 3"
                        },
                    @{
                        TABBAR_ITEM_TEXT_KEY    :   @"Item 4"
                        },
                    ];
    
    mViewTabbarCollectionView.allowsSelection = YES;
    mViewTabbarCollectionView.allowsMultipleSelection = NO;
    
    
    //
    //  setup this pan gesture thing in to the container
    //
    //  until now it's not needed, we will be back on this implementation later
    //
    sliderPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(panGestureHandler:)];
    sliderPanGesture.delegate = self;
    [self.viewControllerContainer addGestureRecognizer:sliderPanGesture];
    
    
    //
    //  initializing collection view bottom ribbon
    //
    collectionViewBottomLayer = [[CALayer alloc] init];
    collectionViewBottomLayer.backgroundColor = TABBAR_BOTTOM_SELECTION_LAYER_COLOR.CGColor;
    [mViewTabbarCollectionView.layer addSublayer:collectionViewBottomLayer];
    collectionViewBottomLayer.frame = CGRectZero;
    
    
    //
    //  dont put it on the top,
    //  if you dare, then put it,
    //  there is a huge history behind it
    //
    //  it will race down through the method
    //
    //      -(void)newSelectedTabbarIndex:(NSUInteger)newSelectedIndex
    //                   whereOldIndexWas:(NSUInteger)oldSelectedIndex
    //
    //  calling the super implementation will call the above method,
    //  but in above method you always expect that all the gui is properly
    //  initialized.
    //
    [super viewDidLoad];
    
    [[[UIAlertView alloc] initWithTitle:@"Tutorial"
                               message:@"Swipe from the left right edge to switch the tab"
                              delegate:nil
                     cancelButtonTitle:@"dismiss"
                      otherButtonTitles:nil, nil] show];
}

-(void)viewDidLayoutSubviews
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)mViewTabbarCollectionView.collectionViewLayout;
    
    layout.sectionInset = UIEdgeInsetsZero;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    CGFloat itemWidth = CGRectGetWidth(mViewTabbarCollectionView.bounds) / TABBAR_ITEM_SHOWN_AT_A_TIME;
    CGFloat itemHeight = CGRectGetHeight(mViewTabbarCollectionView.bounds);
    
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);

    
    collectionViewBottomLayer.frame = CGRectMake(itemWidth * [super getSelectedIndex],
                                                 itemHeight-TABBAR_BOTTOM_SELECTION_LAYER_HEIGHT,
                                                 itemWidth,
                                                 TABBAR_BOTTOM_SELECTION_LAYER_HEIGHT);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark RSCustomTabbarImplementationDelegate
-(CGFloat)heightForTabbarController:(RSCustomTabbarControllerBasic*)tabbarController
{
    return 44.0;
}

-(void)newSelectedTabbarIndex:(NSUInteger)newSelectedIndex
             whereOldIndexWas:(NSUInteger)oldSelectedIndex
{
    NSIndexPath *newSelectedIndexPath = [NSIndexPath indexPathForRow:newSelectedIndex
                                                           inSection:0];
    NSIndexPath *oldSelectedIndexPath = [NSIndexPath indexPathForRow:oldSelectedIndex
                                                           inSection:0];
    
    [mViewTabbarCollectionView selectItemAtIndexPath:newSelectedIndexPath
                                            animated:YES
                                      scrollPosition:UICollectionViewScrollPositionRight];
    
    [self adjustBottomLayerFromIndexPath:oldSelectedIndexPath
                             withPortion:0.0
                             toIndexPath:newSelectedIndexPath
                             withPortion:1.0];

}

#pragma mark UICollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return tabbarItems.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //
    //  grabbing the cell
    //
    Demo6TabbarItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DEMO6_TABBAR_ITEM_CELL_REUSING_ID
                                                                          forIndexPath:indexPath];
    
    //
    //  grabbing the info
    //
    NSDictionary *tabbarItemInfo = tabbarItems[indexPath.row];
    
    //
    //  customizing the cell
    //
    cell.mViewTabbarItemLabel.text = tabbarItemInfo[TABBAR_ITEM_TEXT_KEY];
    
    //
    //  returning the cell
    //
    return cell;
}

#pragma mark UICollectionViewDelegate
-       (void)collectionView:(UICollectionView *)collectionView
  didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self setSelectedViewCotnrollerAtIndex:indexPath.row];
}


#pragma mark UIGestureRecognizerDelegate
// called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
       gestureRecognizer == sliderPanGesture)
    {
        CGPoint touchPoint = [gestureRecognizer locationInView:self.viewControllerContainer];
        
        if(touchPoint.x < DEMO6_SLIDING_PAN_GESTURE_LEFT_RIGHT_OFFSET ||
           touchPoint.x > CGRectGetWidth(self.viewControllerContainer.bounds) - DEMO6_SLIDING_PAN_GESTURE_LEFT_RIGHT_OFFSET)
        {
            //  we can begin working on it
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark Container Pan Gesture Handler
-(void)panGestureHandler:(UIPanGestureRecognizer*)panGesture
{
    static BOOL isGestureStarted = NO;
    static CGPoint startPoint;
    static CGPoint endPoint;
    
    static UIView *currentView;
    static UIView *previousView;
    static UIView *nextView;
    
    
    static NSInteger    previousIndex,
                        currentIndex,
                        nextIndex;
    
    switch (panGesture.state) {
        case UIGestureRecognizerStatePossible:   // the recognizer has not yet recognized its gesture, but may be evaluating touch events. this is the default state
        {
            isGestureStarted = NO;
        }
            break;
        case UIGestureRecognizerStateBegan:      // the recognizer has received touches recognized as the gesture. the action method will be called at the next turn of the run loop
        {
            isGestureStarted = YES;
            startPoint = [panGesture locationInView:self.viewControllerContainer];
            
            
            //cleaning all the views
            currentView = nil;
            previousView = nil;
            nextView = nil;
            
            
            previousIndex = currentIndex = nextIndex = 0;
            
            //
            //  initialize prevView, currentView, nextView
            //
            currentIndex = [self getSelectedIndex];
            
            currentView = [self getSelectedViewController].view;
            
            previousIndex = (NSUInteger)(currentIndex - 1);
            if(previousIndex >= 0)
            {
                previousView = [self getViewControllerAtIndex:previousIndex].view;
            }
            
            nextIndex = (currentIndex + 1);
            if(nextIndex < viewControllers.count)
            {
                nextView = [self getViewControllerAtIndex:nextIndex].view;
            }
            
            // preparing this view to be in the container
            if(previousView && previousView.superview != self.viewControllerContainer)
            {
                previousView.frame = CGRectMake(-self.viewControllerContainer.bounds.size.width,
                                                0,
                                                self.viewControllerContainer.bounds.size.width,
                                                self.viewControllerContainer.bounds.size.height);
                
                [self.viewControllerContainer addSubview:previousView];
                [previousView layoutSubviews];
            }
            
            
            if(nextView && nextView.superview != self.viewControllerContainer)
            {
                nextView.frame = CGRectMake(self.viewControllerContainer.bounds.size.width,
                                            0,
                                            self.viewControllerContainer.bounds.size.width,
                                            self.viewControllerContainer.bounds.size.height);
                
                [self.viewControllerContainer addSubview:nextView];
                [nextView layoutSubviews];
            }
            
            //  disable user interaction of the tabbars
            mViewTabbarCollectionView.userInteractionEnabled = NO;
            
        }
            break;
        case UIGestureRecognizerStateChanged:    // the recognizer has received touches recognized as a change to the gesture. the action method will be called at the next turn of the run loop
        {
            endPoint = [panGesture locationInView:self.viewControllerContainer];
            //
            //  animate the current view controller's view
            //
            
            CGFloat dragX = endPoint.x - startPoint.x;
            
            //
            //  low movement when there is no view controller left
            //
            CGFloat currentOffset = dragX;
            if(dragX > 0 && previousView == nil)
            {
                currentOffset = dragX * 0.3;
            }
            if(dragX < 0 && nextView == nil)
            {
                currentOffset = dragX * 0.3;
            }
            
            CGFloat prevViewVisiblePortion = 0;
            CGFloat currentViewVisiblePortion = 0;
            CGFloat nextViewVisiblePortion = 0;
            
            
            if(previousView)
            {
                prevViewVisiblePortion = previousView.frame.origin.x + previousView.bounds.size.width;
                
                if(prevViewVisiblePortion > 0)
                {
                    prevViewVisiblePortion /= self.viewControllerContainer.bounds.size.width;
                }
                else{
                    prevViewVisiblePortion = 0.0;
                }
            }
            
            
            if(currentView)
            {
                if(currentView.frame.origin.x > 0)
                {
                    currentViewVisiblePortion = currentView.bounds.size.width - currentView.frame.origin.x;
                }
                else
                {
                    currentViewVisiblePortion = currentView.bounds.size.width + currentView.frame.origin.x;
                }
                
                if(currentViewVisiblePortion > 0)
                {
                    currentViewVisiblePortion /= self.viewControllerContainer.bounds.size.width;
                }
                else{
                    currentViewVisiblePortion = 0;
                }
                
            }
            
            if(nextView)
            {
                nextViewVisiblePortion = nextView.frame.origin.x - self.viewControllerContainer.bounds.size.width;
                
                if(nextViewVisiblePortion < 0)
                {
                    nextViewVisiblePortion /= -self.viewControllerContainer.bounds.size.width;
                }
                else{
                    nextViewVisiblePortion = 0;
                }
            }
            
            if(prevViewVisiblePortion > 0 && currentViewVisiblePortion > 0)
            {
                [self adjustBottomLayerFromIndexPath:[NSIndexPath indexPathForRow:previousIndex inSection:0]
                                         withPortion:prevViewVisiblePortion
                                         toIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0]
                                         withPortion:currentViewVisiblePortion];                
            }
            else if (currentViewVisiblePortion > 0 && nextViewVisiblePortion > 0)
            {
                [self adjustBottomLayerFromIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0]
                                         withPortion:currentViewVisiblePortion
                                         toIndexPath:[NSIndexPath indexPathForRow:nextIndex inSection:0]
                                         withPortion:nextViewVisiblePortion];
            }
            else if (nextViewVisiblePortion > 0 && prevViewVisiblePortion > 0)
            {
                [self adjustBottomLayerFromIndexPath:[NSIndexPath indexPathForRow:nextIndex inSection:0]
                                         withPortion:nextViewVisiblePortion
                                         toIndexPath:[NSIndexPath indexPathForRow:previousIndex inSection:0]
                                         withPortion:prevViewVisiblePortion];
            }
            
            //
            //  simulate the pan gesture moving
            //  on UIViewController's view
            //
            [UIView animateWithDuration:0.2 animations:^{
                
                currentView.frame = CGRectMake(0 + currentOffset,
                                               currentView.frame.origin.y,
                                               currentView.frame.size.width,
                                               currentView.frame.size.height);
                
                
                if(previousView)
                {
                    previousView.frame = CGRectMake(dragX - currentView.frame.size.width,
                                                    0,
                                                    previousView.frame.size.width,
                                                    previousView.frame.size.height);
                }
                
                
                if(nextView)
                {
                    nextView.frame = CGRectMake(currentView.frame.size.width + dragX,
                                                0,
                                                nextView.frame.size.width,
                                                nextView.frame.size.height);
                }
                
            }];
            
        }
            break;
        case UIGestureRecognizerStateEnded:      // the recognizer has received touches recognized as the end of the gesture. the action method will be called at the next turn of the run loop and the recognizer will be reset to UIGestureRecognizerStatePossible
        case UIGestureRecognizerStateCancelled:  // the recognizer has received touches resulting in the cancellation of the gesture. the action method will be called at the next turn of the run loop. the recognizer will be reset to UIGestureRecognizerStatePossible
        case UIGestureRecognizerStateFailed:     // the recognizer has received a touch sequence that can not be recognized as the gesture. the action method will not be called and the recognizer will be reset to UIGestureRecognizerStatePossible
        {
            isGestureStarted = NO;
            
            CGFloat prevViewVisiblePortion = 0;
            CGFloat currentViewVisiblePortion = 0;
            CGFloat nextViewVisiblePortion = 0;
            
            if(previousView)
            {
                prevViewVisiblePortion = previousView.frame.origin.x + previousView.bounds.size.width;
                
                if(prevViewVisiblePortion > 0)
                {
                    prevViewVisiblePortion /= self.viewControllerContainer.bounds.size.width;
                }
                else{
                    prevViewVisiblePortion = 0.0;
                }
            }
            
            
            if(currentView)
            {
                if(currentView.frame.origin.x > 0)
                {
                    currentViewVisiblePortion = currentView.bounds.size.width - currentView.frame.origin.x;
                }
                else
                {
                    currentViewVisiblePortion = currentView.bounds.size.width + currentView.frame.origin.x;
                }
                
                if(currentViewVisiblePortion > 0)
                {
                    currentViewVisiblePortion /= self.viewControllerContainer.bounds.size.width;
                }
                else{
                    currentViewVisiblePortion = 0;
                }
                
            }
            
            if(nextView)
            {
                nextViewVisiblePortion = nextView.frame.origin.x - self.viewControllerContainer.bounds.size.width;
                
                if(nextViewVisiblePortion < 0)
                {
                    nextViewVisiblePortion /= -self.viewControllerContainer.bounds.size.width;
                }
                else{
                    nextViewVisiblePortion = 0;
                }
            }
            
            //  finding who will sustain next
            BOOL isPreviousIsTheViewController = false;
            BOOL isCurrentIsTheViewController = false;
            BOOL isNextIsTheViewController = false;
            
            CGFloat xPrevious = 0,xCurrent = 0,xNext = 0;
            
            if(currentViewVisiblePortion > prevViewVisiblePortion && currentViewVisiblePortion > nextViewVisiblePortion)
            {
                xPrevious = -currentView.frame.size.width;
                xCurrent = 0;
                xNext = currentView.frame.size.width;
                
                isCurrentIsTheViewController = YES;
            }
            else if(prevViewVisiblePortion > nextViewVisiblePortion && prevViewVisiblePortion > currentViewVisiblePortion)
            {
                xPrevious = 0;
                xCurrent = currentView.frame.size.width;
                xNext = 2 * currentView.frame.size.width;
                
                isPreviousIsTheViewController = YES;
            }
            else if(nextViewVisiblePortion > currentViewVisiblePortion && nextViewVisiblePortion > prevViewVisiblePortion)
            {
                xPrevious = - 2 * currentView.frame.size.width;
                xCurrent = -currentView.frame.size.width;
                xNext = 0;
                
                isNextIsTheViewController = YES;
            }
            
            
            
            
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
            [UIView animateWithDuration:0.3 animations:^{
                
                currentView.frame = CGRectMake(xCurrent,
                                               currentView.frame.origin.y,
                                               currentView.frame.size.width,
                                               currentView.frame.size.height);
                
                
                if(nextView)
                {
                    nextView.frame = CGRectMake(xNext,
                                                0,
                                                nextView.frame.size.width,
                                                nextView.frame.size.height);
                }
                
                if(previousView)
                {
                    previousView.frame = CGRectMake(xPrevious,
                                                    0,
                                                    previousView.frame.size.width,
                                                    previousView.frame.size.height);
                }
                

                
                
            } completion:^(BOOL finished) {
                
                //  to decide where to go
                
                //cleaning process need to be done
                if(isCurrentIsTheViewController)
                {
                    //  remove prev & next from the super view
                    [previousView removeFromSuperview];
                    [nextView removeFromSuperview];
                    
                    //                    //
                    //                    //  this may seem not necessary, but while swiping
                    //                    //  through, viewWillAppear,viewDidAppear of the
                    //                    //  nextViewController & previousViewController is
                    //                    //  called, they may change some status, so to make sure,
                    //                    //  everything is alright we will again same view controller
                    //                    //
                    //                    //
                    
                    //
                    //  nothing gonna confirm current
                    //  view controller that, it is
                    //  the last selected view controller, because selecting the last view already selected
                    //  view controller has no effect
                    //
                    id<RSCustomTabbarControllerLifecycleDelegte> currentVC= (id<RSCustomTabbarControllerLifecycleDelegte>)
                    [self getSelectedViewController];
                    
                    if([currentVC respondsToSelector:@selector(viewControllerDidAppearAnimationFinishedInTabbar:atIndex:)])
                    {
                        [currentVC viewControllerDidAppearAnimationFinishedInTabbar:self
                                                                            atIndex:currentIndex];
                    }
                }
                else if(isPreviousIsTheViewController)
                {
                    //  remove current & next from super view
                    [currentView removeFromSuperview];
                    [nextView removeFromSuperview];
                    
                    NSUInteger viewControllerIndex = [self getSelectedIndex] - 1;
                    [self setSelectedViewCotnrollerAtIndex:viewControllerIndex];
                }
                else if(isNextIsTheViewController)
                {
                    //  remove previous & current from the super view
                    [currentView removeFromSuperview];
                    [nextView removeFromSuperview];
                    
                    NSUInteger viewControllerIndex = [self getSelectedIndex] + 1;
                    [self setSelectedViewCotnrollerAtIndex:viewControllerIndex];
                }
                
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                
                //  enable user interaction of the tabbars
                mViewTabbarCollectionView.userInteractionEnabled = YES;
            }];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark private helper method
-(void)adjustBottomLayerFromIndexPath:(NSIndexPath*)fromIndexPath
                          withPortion:(CGFloat)fromPortion
                          toIndexPath:(NSIndexPath*)toIndexPath
                          withPortion:(CGFloat)toPortion
{
    Demo6TabbarItemCell *fromCell = (Demo6TabbarItemCell*)[mViewTabbarCollectionView cellForItemAtIndexPath:fromIndexPath];
    Demo6TabbarItemCell *toCell   = (Demo6TabbarItemCell*)[mViewTabbarCollectionView cellForItemAtIndexPath:toIndexPath];
    
    CGPoint fromCellOrigin  = [fromCell convertPoint:CGPointZero toView:mViewTabbarCollectionView];
    CGPoint toCellOrigin    = [toCell convertPoint:CGPointZero toView:mViewTabbarCollectionView];
    
    //
    //  weighted average of their visible portion
    //
    CGFloat calculatedX = fromCellOrigin.x * fromPortion + toCellOrigin.x * toPortion;
    
    
    collectionViewBottomLayer.frame = CGRectMake(calculatedX,
                                                 CGRectGetMinY(collectionViewBottomLayer.frame),
                                                 CGRectGetWidth(collectionViewBottomLayer.frame),
                                                 CGRectGetHeight(collectionViewBottomLayer.frame));
}

@end
