//
//  Demo6TabbarControllerViewController.h
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

#import "RSCustomTabbarController.h"

#define TABBAR_ITEM_TEXT_KEY            @"tabbar.item.text.key"
#define TABBAR_ITEM_SHOWN_AT_A_TIME     3.5

#define DEMO6_SLIDING_PAN_GESTURE_LEFT_RIGHT_OFFSET   40


#define TABBAR_BOTTOM_SELECTION_LAYER_HEIGHT    5
#define TABBAR_BOTTOM_SELECTION_LAYER_COLOR     [UIColor greenColor]


@interface Demo6TabbarControllerViewController : RSCustomTabbarController <RSCustomTabbarImplementationDelegate>


#pragma mark RSCustomTabbarImplementationDelegate
@property IBOutlet UIView *viewControllerContainer;

@property IBOutletCollection(NSLayoutConstraint) NSArray *tabbarContainerHeight;
@property IBOutletCollection(NSLayoutConstraint)NSArray *tabbarWidgetHolderTop;



@end
