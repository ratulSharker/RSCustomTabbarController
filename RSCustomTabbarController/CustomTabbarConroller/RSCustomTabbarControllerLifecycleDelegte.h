//
//  RSCustomTabbarLifecycleDelegte.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/26/16.
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


#ifndef RSCustomTabbarLifecycleDelegte_h
#define RSCustomTabbarLifecycleDelegte_h

@class RSCustomTabbarControllerBasic;

@protocol RSCustomTabbarControllerLifecycleDelegte <NSObject>

//
//  These method's are optional method
//  as the viewController lifecycle (viewDidLoad, viewDidAppear, viewWillAppear) method
//  if none of them are specified, then it's okay, you won't get any error or crash for them
//  just like UIKit huh...
//


//
//  this function will whenever the view controller appeared.
//  if transition animation is implemented, then this method
//  will be called on the selectedViewController right after the
//  animation completed. If no animation provided, it will be called
//  just after placing everything in the right place. In either case
//  this method will be called after everything is done.
//
-(void)viewControllerDidAppearAnimationFinishedInTabbar:(RSCustomTabbarControllerBasic *)customTabbar;

@end



#endif /* RSCustomTabbarLifecycleDelegte_h */
