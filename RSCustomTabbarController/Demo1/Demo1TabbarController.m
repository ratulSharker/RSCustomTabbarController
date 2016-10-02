//
//  Demo1TabbarController.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 8/29/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "Demo1TabbarController.h"
#import "FadingTabbarTransitionAnimation.h"
#import "SlidingTabbarTransitionAnimation.h"

@interface Demo1TabbarController ()
{
    NSArray<UIButton*> *buttonArr;
    
    
}
@property (strong, nonatomic) IBOutlet UIButton *mViewBtn0;
@property (strong, nonatomic) IBOutlet UIButton *mViewBtn1;
@property (strong, nonatomic) IBOutlet UIButton *mViewBtn2;
@property (strong, nonatomic) IBOutlet UIButton *mViewBtn3;




@end

@implementation Demo1TabbarController




#pragma mark life cycle
-(void)viewDidLoad
{
    _mViewBtn0.tag = 0;
    _mViewBtn1.tag = 1;
    _mViewBtn2.tag = 2;
    _mViewBtn3.tag = 3;
    
    
    buttonArr = @[_mViewBtn0, _mViewBtn1, _mViewBtn2, _mViewBtn3];

    super.transitionAnimationDelegate = [SlidingTabbarTransitionAnimation new];
    
    [super viewDidLoad];
}


#pragma mark CustomTabbarImplementationDelegate
-(CGFloat)heightForTabbarController:(RSCustomTabbarController*)tabbarController
{
    return 56;
}
-(void)newSelectedTabbarIndex:(NSUInteger)newSelectedIndex whereOldIndexWas:(NSUInteger)oldSelectedIndex
{
    buttonArr[oldSelectedIndex].selected = NO;
    buttonArr[newSelectedIndex].selected = YES;
}




#pragma mark IBActions
-(IBAction)tabbarButtonPressed:(UIButton*)sender
{
    NSLog(@"tabbar button pressed");
    [super setSelectedViewCotnrollerAtIndex:sender.tag];
}


@end
