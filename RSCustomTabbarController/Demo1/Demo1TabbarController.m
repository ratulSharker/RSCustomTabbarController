//
//  Demo1TabbarController.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 8/29/16.
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
    if(newSelectedIndex == oldSelectedIndex)
    {
        //it's for the first time
        buttonArr[newSelectedIndex].selected = YES;
    }
    else
    {
        buttonArr[oldSelectedIndex].selected = NO;
        buttonArr[newSelectedIndex].selected = YES;
    }
}




#pragma mark IBActions
-(IBAction)tabbarButtonPressed:(UIButton*)sender
{
    NSLog(@"tabbar button pressed");
    [super setSelectedViewCotnrollerAtIndex:sender.tag];
}


@end
