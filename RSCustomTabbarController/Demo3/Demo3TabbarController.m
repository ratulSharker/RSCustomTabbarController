//
//  Demo3TabbarController.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 9/10/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "Demo3TabbarController.h"
#import "FadingTabbarTransitionAnimation.h"

#define DRAGGING_TOP_DISTANCE       8
#define DRAGGING_LEADING_DISTANCE   8

@interface Demo3TabbarController ()
{
    NSArray<UIButton*> *btnArr;
    NSArray<UIView *> *tabbarArr;
}
@property (strong, nonatomic) IBOutlet UIButton *tabbarBtn0;
@property (strong, nonatomic) IBOutlet UIButton *tabbarBtn1;
@property (strong, nonatomic) IBOutlet UIButton *tabbarBtn2;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tabbar0Top;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tabbar0Leading;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tabbar1Top;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tabbar1Leading;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tabbar2Top;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tabbar2Leading;

@property (strong, nonatomic) IBOutlet UIView *tabbarHolder0;
@property (strong, nonatomic) IBOutlet UIView *tabbarHolder1;
@property (strong, nonatomic) IBOutlet UIView *tabbarHolder2;

@end

@implementation Demo3TabbarController

- (void)viewDidLoad {
    
    _tabbarBtn0.tag = 0;
    _tabbarBtn1.tag = 1;
    _tabbarBtn2.tag = 2;
    
    btnArr = @[_tabbarBtn0,
               _tabbarBtn1,
               _tabbarBtn2];
    
    tabbarArr = @[_tabbarHolder0,
                  _tabbarHolder1,
                  _tabbarHolder2];
    
    //
    //  providing appropriate transition animation
    //
    super.transitionAnimationDelegate = [FadingTabbarTransitionAnimation new];
    
    
    //  adding gesture recognizer
    [self addGestureRecognizerToTabbars];
    
    //
    //  we want to execute the super view did load
    //  just after the tags been set
    //
    [super viewDidLoad];
    
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
-(CGFloat)heightForTabbarController:(RSCustomTabbarController*)tabbarController
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
    if(animated){
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        if(visible){
            [self setAllTabbarHolderVisibility:YES];
            [self setAllTabbarHolderAlphaLevel:0.0];
        }
        else{
            [self setAllTabbarHolderAlphaLevel:1.0];
        }
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             [self setAllTabbarHolderAlphaLevel:(CGFloat)visible];
                         }
                         completion:^(BOOL finished) {
                             [self setAllTabbarHolderVisibility:visible];
                             [self setAllTabbarHolderAlphaLevel:1.0];
                             
                             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         }];
    }
    else
    {
        [self setAllTabbarHolderVisibility:visible];
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
        case UIGestureRecognizerStateBegan:{
            [self gestureStartEndViewSettings:holder isStart:YES];
            startPoint = [gesture locationInView:holder];
            
            viewLeadingConstraint = [self getConstraintAccordingToGesture:gesture isLeading:YES];
            viewTopConstraint = [self getConstraintAccordingToGesture:gesture isLeading:NO];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            //update the view constraint
            [self translateViewAccordingToGesture:gesture
                                   withStartPoint:startPoint
                                leadingConstraint:viewLeadingConstraint
                                    topConstraint:viewTopConstraint];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:{
            [self gestureStartEndViewSettings:holder isStart:NO];
            
            viewLeadingConstraint = nil;
            viewTopConstraint = nil;
            startPoint = CGPointZero;
        }
            
        default:
            break;
    }
}

#pragma mark private helper methods
-(void)setAllTabbarHolderVisibility:(BOOL)visibility
{
    _tabbarHolder0.hidden = _tabbarHolder1.hidden = _tabbarHolder2.hidden = !visibility;
}
-(void)setAllTabbarHolderAlphaLevel:(CGFloat)alpha
{
    _tabbarHolder0.alpha = _tabbarHolder1.alpha = _tabbarHolder2.alpha = alpha;
}
-(void)addGestureRecognizerToTabbars
{
    for(UIView *tabbarHolder in tabbarArr)
    {
        [tabbarHolder addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(panGesture:)]];
    }
}

//
//  here starts all gesture related helper methods
//
-(void)gestureStartEndViewSettings:(UIView*)holderView isStart:(BOOL)gestureStart
{
    if(gestureStart)
    {
        //chnage the view properties to selected
        holderView.layer.borderWidth = 3.0;
        holderView.layer.borderColor = [UIColor yellowColor].CGColor;
        [self.view bringSubviewToFront:holderView];
    }
    else
    {
        //change the view properties to normal
        holderView.layer.borderWidth = 0;
        holderView.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

-(NSLayoutConstraint*)getConstraintAccordingToGesture:(UIPanGestureRecognizer*)gesture isLeading:(BOOL)isLeading
{
    if(gesture.view == _tabbarHolder0)
    {
        return isLeading ? _tabbar0Leading : _tabbar0Top;
    }
    else if(gesture.view == _tabbarHolder1)
    {
        return isLeading ? _tabbar1Leading : _tabbar1Top;
    }
    else if(gesture.view == _tabbarHolder2)
    {
        return isLeading ? _tabbar2Leading : _tabbar2Top;
    }
    return nil;
}


-(void)translateViewAccordingToGesture:(UIPanGestureRecognizer *)gesture
                        withStartPoint:(CGPoint)startPoint
                     leadingConstraint:(NSLayoutConstraint*)viewLeadingConstraint
                         topConstraint:(NSLayoutConstraint*)viewTopConstraint
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



@end
