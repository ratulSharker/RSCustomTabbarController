//
//  Demo2TabbarController.m
//  CustomTabbarController
//
//  Created by Ratul Sharker on 8/31/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

#import "Demo2TabbarController.h"

@interface Demo2TabbarController ()
{
    IBOutlet UIButton *barBtn0;
    IBOutlet UIButton *barBtn1;
    IBOutlet UIButton *barBtn2;
    IBOutlet UIButton *barBtn3;
    
    NSArray<UIButton*> *allBtns;
    
    IBOutlet UIView *tabbar0;
    IBOutlet UIView *tabbar1;
    IBOutlet UIView *tabbar2;
    IBOutlet UIView *tabbar3;
    
    NSArray<UIView*> *allTabbar;
}



@end

@implementation Demo2TabbarController

- (void)viewDidLoad {
    
    allBtns = @[
                barBtn0,
                barBtn1,
                barBtn2,
                barBtn3
                ];
    
    allTabbar = @[
                  tabbar0,
                  tabbar1,
                  tabbar2,
                  tabbar3
                  ];
    
    barBtn0.tag = 0;
    barBtn1.tag = 1;
    barBtn2.tag = 2;
    barBtn3.tag = 3;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    
    [super viewDidLoad];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark IBAction
-(IBAction)onTabbarButtonPressed:(UIButton*)sender
{
    [super setSelectedViewCotnrollerAtIndex:sender.tag];
}



#pragma mark CustomTabbarImplementationDelegate
-(CGFloat)heightForTabbarController:(CustomTabbarController*)tabbarController
{
    return 200;
}
-(void)newSelectedTabbarIndex:(NSUInteger)newSelectedIndex
             whereOldIndexWas:(NSUInteger)oldSelectedIndex
{
    
    if(oldSelectedIndex == newSelectedIndex)
    {
        //
        //  this situation happened for the first time only,
        //  because we dont want to add another function
        //  for this callback, thats how we sharing the
        //  function
        //
        allBtns[newSelectedIndex].selected = YES;
        allTabbar[newSelectedIndex].backgroundColor = [UIColor whiteColor];
    }
    else
    {
        allBtns[newSelectedIndex].selected = YES;
        allBtns[oldSelectedIndex].selected = NO;
        
        allTabbar[newSelectedIndex].backgroundColor = [UIColor whiteColor];
        allTabbar[oldSelectedIndex].backgroundColor = [UIColor lightGrayColor];
    }
    

}

@end
