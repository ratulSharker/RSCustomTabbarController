//
//  Demo2TabbarController.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 8/31/16.
//  Copyright © 2016 funtoos.
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

#import "Demo2TabbarController.h"
#import "JumpInTabbarTransitionAnimation.h"

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
    
    
    super.transitionAnimationDelegate = [JumpInTabbarTransitionAnimation new];
    
    
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
-(CGFloat)heightForTabbarController:(RSCustomTabbarController*)tabbarController
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
