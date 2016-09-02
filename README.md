# CustomTabbarController
This is super flexible Custom tab bar controller implementation. You have the complete opportunity to customise according to your necessity.

## Simple tutorial

First copy the `CustomTabbarController` (link need to be added) in your project.

Second create a new class extending from the base class `CustomTabbarController`. Let the new class name is `Demo1TabbarController`.
`Demo1TabbarController.h` looks like following. 
```obj-c

#import <UIKit/UIKit.h>
#import "CustomTabbarController.h"

@interface Demo1TabbarController : CustomTabbarController 

@end
```
Now implement the `CustomTabbarImplementationDelegate` by adding following properties & methods in 'Demo1TabbarController'

```obj-c
@property UIView *viewControllerContainer;

@property NSArray<NSLayoutConstraint*> *tabbarContainerHeight;
@property NSArray<NSLayoutConstraint*> *tabbarWidgetHolderTop;

-(CGFloat)heightForTabbarController:(CustomTabbarController*)tabbarController;
-(void)newSelectedTabbarIndex:(NSUInteger)newSelectedIndex whereOldIndexWas:(NSUInteger)oldSelectedIndex;
```

Before getting into nitty gitty details, first grab some key concept about this protocol. This `CustomTabbarImplentationDelegate` will
ask for these 3 properties & 2 method. You are about to apply your own graphical design, but how should `CustomTabbarController` would 
know about which is your view controller container and what will act as an tabbar container. Thats why this protocol is designed.

now the `Demo1TabbarController.h` is looks like
```obj-c
#import <UIKit/UIKit.h>
#import "CustomTabbarController.h"

@interface Demo1TabbarController : CustomTabbarController <CustomTabbarImplementationDelegate>

#pragma mark implementation properties
@property IBOutlet UIView *viewControllerContainer;
@property IBOutletCollection (NSLayoutConstraint) NSArray *tabbarContainerHeight;
@property IBOutletCollection (NSLayoutConstraint) NSArray *tabbarWidgetHolderTop;

@end
```

and the `Demo1TabbarController.m` will look like
```obj-c
#import "Demo1TabbarController.h"

@interface Demo1TabbarController ()

@end

@implementation Demo1TabbarController

#pragma mark life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark CustomTabbarImplementationDelegate
-(CGFloat)heightForTabbarController:(CustomTabbarController*)tabbarController
{
    //todo -- implementation
}
-(void)newSelectedTabbarIndex:(NSUInteger)newSelectedIndex whereOldIndexWas:(NSUInteger)oldSelectedIndex
{
    //todo -- implementation
}
@end
```

For now we are done with class. Now we need to add a inteface builder file (storyboard/nib) file for designing the tabbar controller.
Following is the hierarchy we will be following to create the `Demo1TabbarContorller`

```
      UIVIewController
      |
      |--> self.view
          |
          |--> viewController container
          |--> tabbar container
              |
              |--> button
```
