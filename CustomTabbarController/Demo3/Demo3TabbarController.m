//
//  Demo3TabbarController.m
//  CustomTabbarController
//
//  Created by Ratul Sharker on 9/10/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

#import "Demo3TabbarController.h"
#import "FadingTabbarTransitionAnimation.h"

#define DRAGGING_TOP_DISTANCE       8
#define DRAGGING_LEADING_DISTANCE   8

@interface Demo3TabbarController ()

@end

@implementation Demo3TabbarController
{
    IBOutlet UIButton *tabbarBtn0;
    IBOutlet UIButton *tabbarBtn1;
    IBOutlet UIButton *tabbarBtn2;

    NSArray<UIButton*> *btnArr;

    IBOutlet UIView *tabbarHolder0;
    IBOutlet UIView *tabbarHolder1;
    IBOutlet UIView *tabbarHolder2;
    
    NSArray<UIView *> *tabbarArr;
    
    IBOutlet NSLayoutConstraint *tabbar0Top;
    IBOutlet NSLayoutConstraint *tabbar0Leading;
    
    IBOutlet NSLayoutConstraint *tabbar1Top;
    IBOutlet NSLayoutConstraint *tabbar1Leading;
    
    IBOutlet NSLayoutConstraint *tabbar2Top;
    IBOutlet NSLayoutConstraint *tabbar2Leading;
    
}
- (void)viewDidLoad {
    
    tabbarBtn0.tag = 0;
    tabbarBtn1.tag = 1;
    tabbarBtn2.tag = 2;
    
    btnArr = @[
               tabbarBtn0,
               tabbarBtn1,
               tabbarBtn2
               ];
    
    tabbarArr = @[
                  tabbarHolder0,
                  tabbarHolder1,
                  tabbarHolder2
                  ];
    
    //
    //  providing appropriate transition animation
    //
    super.transitionAnimationDelegate = [FadingTabbarTransitionAnimation new];
    
    //
    //  we want to execute the super view did load
    //  just after the tags been set
    //
    [super viewDidLoad];
    
    
    UIPanGestureRecognizer *panGesture0 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    UIPanGestureRecognizer *panGesture1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    UIPanGestureRecognizer *panGesture2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    
    [tabbarHolder0 addGestureRecognizer:panGesture0];
    [tabbarHolder1 addGestureRecognizer:panGesture1];
    [tabbarHolder2 addGestureRecognizer:panGesture2];
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

#pragma mark CustomTabbarImplementationDelegate
-(CGFloat)heightForTabbarController:(CustomTabbarController*)tabbarController
{
    return 60;
}

-(void)newSelectedTabbarIndex:(NSUInteger)newSelectedIndex
             whereOldIndexWas:(NSUInteger)oldSelectedIndex
{
    if(newSelectedIndex != oldSelectedIndex)
    {
        //simple cases
        tabbarArr[oldSelectedIndex].backgroundColor = [UIColor lightGrayColor];
        tabbarArr[newSelectedIndex].backgroundColor = [UIColor whiteColor];
        
        btnArr[oldSelectedIndex].selected = NO;
        btnArr[newSelectedIndex].selected = YES;
    }
    else
    {
        tabbarArr[newSelectedIndex].backgroundColor = [UIColor whiteColor];
        btnArr[newSelectedIndex].selected = YES;
        
    }
}

#pragma mark custom implementation
-(void)setTabbarVisibility:(BOOL)visible animated:(BOOL)animated
{
    //won't call super here
    if(animated)
    {
        if(visible)
        {
            tabbarHolder0.alpha = tabbarHolder1.alpha = tabbarHolder2.alpha = 0.0;
            tabbarHolder0.hidden = tabbarHolder1.hidden = tabbarHolder2.hidden = NO;
        }
        else
        {
            tabbarHolder0.alpha = tabbarHolder1.alpha = tabbarHolder2.alpha = 1.0;
        }
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             if(visible)
                             {
                                 tabbarHolder0.alpha = tabbarHolder1.alpha = tabbarHolder2.alpha = 1.0;
                             }
                             else
                             {
                                 tabbarHolder0.alpha = tabbarHolder1.alpha = tabbarHolder2.alpha = 0.0;
                             }

                         }
                         completion:^(BOOL finished) {
                             tabbarHolder0.hidden = !visible;
                             tabbarHolder1.hidden = !visible;
                             tabbarHolder2.hidden = !visible;
                             tabbarHolder0.alpha = tabbarHolder1.alpha = tabbarHolder2.alpha = 1.0;
                             
                         }];
    }
    else
    {
        tabbarHolder0.hidden = !visible;
        tabbarHolder1.hidden = !visible;
        tabbarHolder2.hidden = !visible;
    }
}

#pragma mark IBAction
-(IBAction)onTabbarBtnPressed:(UIButton*)sender
{
    [super setSelectedViewCotnrollerAtIndex:sender.tag];
}

#pragma mark gesture recongnizer
-(void)panGesture:(UIPanGestureRecognizer*)gesture
{
    UIView *holder = gesture.view;
    static CGPoint startPoint;
    static NSLayoutConstraint *viewLeadingConstraint, *viewTopConstraint;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            //chnage the view properties to selected
            holder.layer.borderWidth = 3.0;
            holder.layer.borderColor = [UIColor yellowColor].CGColor;
            
            startPoint = [gesture locationInView:holder];
            
            if(holder == tabbarHolder0)
            {
                viewLeadingConstraint = tabbar0Leading;
                viewTopConstraint = tabbar0Top;
            }
            else if(holder == tabbarHolder1)
            {
                viewLeadingConstraint = tabbar1Leading;
                viewTopConstraint = tabbar1Top;
            }
            else if(holder == tabbarHolder2)
            {
                viewLeadingConstraint = tabbar2Leading;
                viewTopConstraint = tabbar2Top;
            }
            
            [self.view bringSubviewToFront:holder];
            
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {

            //update the view constraint
            CGPoint translatedPoint = [gesture locationInView:self.view];
            
            translatedPoint.x = translatedPoint.x - startPoint.x;
            translatedPoint.y = translatedPoint.y - startPoint.y;
            
            if(viewLeadingConstraint && translatedPoint.x > DRAGGING_LEADING_DISTANCE)
            {
                viewLeadingConstraint.constant = translatedPoint.x;
            }
            
            if(viewTopConstraint && translatedPoint.y > DRAGGING_TOP_DISTANCE)
            {
                viewTopConstraint.constant = translatedPoint.y;
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            //change the view properties to normal
            holder.layer.borderWidth = 0;
            holder.layer.borderColor = [UIColor clearColor].CGColor;
            
            viewLeadingConstraint = nil;
            viewTopConstraint = nil;
            startPoint = CGPointZero;
        }
            
        default:
            break;
    }
    
}

@end
