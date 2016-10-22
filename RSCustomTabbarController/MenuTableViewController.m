//
//  MenuViewController.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 9/2/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "MenuTableViewController.h"
#import "MenuTableCell.h"
#import "Demo1TabbarController.h"
#import "Demo2TabbarController.h"
#import "Demo3TabbarController.h"
#import "Demo4TabbarController.h"
#import "RSCustomTabbarController-SWift.h"      //  this one is for importing swift classes into objective-c
#import "AppDelegate.h"

#define MENU_ITEM_TITLE_KEY         @"menu.item.title"
#define MENU_ITEM_DESCRIPTION_KEY   @"menu.item.description"
#define MENU_ITEM_NUMBER_OF_VC      @"menu.item.number.of.vc"
#define MENU_ITEM_HANDLER_SELECTOR  @"menu.item.selector"



@interface MenuTableViewController ()<RSCustomTabbarDelegate>


@end

@implementation MenuTableViewController
{
    NSArray <NSDictionary*> *menuData;
    
    NSUInteger initialSelectedTabbarIndex;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    menuData = @[
                 @{
                     MENU_ITEM_TITLE_KEY : @"Demo 1",
                     MENU_ITEM_DESCRIPTION_KEY : @"A simple trivial tabbar example",
                     MENU_ITEM_NUMBER_OF_VC : [NSNumber numberWithInteger:4],
                     MENU_ITEM_HANDLER_SELECTOR : NSStringFromSelector(@selector(showOnDemo1))
                     },
                 @{
                     MENU_ITEM_TITLE_KEY : @"Demo 2",
                     MENU_ITEM_DESCRIPTION_KEY : @"Multiple tabbar in single tab controlller",
                     MENU_ITEM_NUMBER_OF_VC : [NSNumber numberWithInteger:4],
                     MENU_ITEM_HANDLER_SELECTOR : @"showOnDemo2"
                    
                     },
                 @{
                     MENU_ITEM_TITLE_KEY: @"Demo 3",
                     MENU_ITEM_DESCRIPTION_KEY: @"Movable tabbar",
                     MENU_ITEM_NUMBER_OF_VC : [NSNumber numberWithInt:3],
                     MENU_ITEM_HANDLER_SELECTOR : @"showOnDemo3"
                     },
                 @{
                     MENU_ITEM_TITLE_KEY: @"Demo 4",
                     MENU_ITEM_DESCRIPTION_KEY: @"Browser Like dynamic tabbar",
                     MENU_ITEM_NUMBER_OF_VC : [NSNumber numberWithInt:1],
                     MENU_ITEM_HANDLER_SELECTOR : @"showOnDemo4"
                     },
                 @{
                     MENU_ITEM_TITLE_KEY: @"Demo 5",
                     MENU_ITEM_DESCRIPTION_KEY: @"Working with Swift",
                     MENU_ITEM_NUMBER_OF_VC : [NSNumber numberWithInt:1],
                     MENU_ITEM_HANDLER_SELECTOR : @"showOnDemo5"
                     }
                 ];
    
    
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setCurrentNavigationController:self.navigationController];
    
    
    //
    //  for self sizing row
    //
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 121;
    
    self.title = @"Demo List";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
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


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return menuData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableCell *customCell = (MenuTableCell*)    [tableView dequeueReusableCellWithIdentifier:@"menu_cell"];
    
    NSDictionary *singleMenuData = menuData[indexPath.row];
    customCell.titleLabel.text = singleMenuData [MENU_ITEM_TITLE_KEY];
    customCell.descriptionLabel.text = singleMenuData [MENU_ITEM_DESCRIPTION_KEY];
    
    NSNumber *numberOfViewController = singleMenuData[MENU_ITEM_NUMBER_OF_VC];
    
    //
    //  kept it 1 indexing
    //
    customCell.initialViewControllerSelectorStepper.minimumValue = 1;
    customCell.initialViewControllerSelectorStepper.maximumValue = numberOfViewController.integerValue;
    
    customCell.initialViewControllerSelectorStepper.value = 1;
    customCell.stepperStatusLabel.text = [NSString stringWithFormat:@"initial vc 1/%ld", (long)numberOfViewController.integerValue];
    
    
    return customCell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{

    MenuTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSUInteger oneIndexedVal = cell.initialViewControllerSelectorStepper.value;
    initialSelectedTabbarIndex = oneIndexedVal - 1;
    
    NSDictionary *menuDataItem = menuData[indexPath.row];
    
    NSString *selectorString  = menuDataItem[MENU_ITEM_HANDLER_SELECTOR];
    SEL selector = NSSelectorFromString(selectorString);
    
    
    if([self respondsToSelector:selector])
    {
        [self performSelector:selector];
    }
    else
    {
        NSLog(@"selector not found in self");
    }
}


#pragma mark private helper
-(void)showOnDemo1
{
    UIStoryboard *childsStory = [UIStoryboard storyboardWithName:@"childs" bundle:[NSBundle mainBundle]];
    
    UIViewController *first = [childsStory instantiateViewControllerWithIdentifier:@"firstVC"],
    *second = [childsStory instantiateViewControllerWithIdentifier:@"secondVC"],
    *third = [childsStory instantiateViewControllerWithIdentifier:@"thirdVC"],
    *fourth = [childsStory instantiateViewControllerWithIdentifier:@"fourthVC"];
    
    UIStoryboard *tabbarStory = [UIStoryboard storyboardWithName:@"demo1" bundle:[NSBundle mainBundle]];
    Demo1TabbarController *tabbarController = [tabbarStory instantiateInitialViewController];
    
    
    [tabbarController setViewControllers:@[first, second, third, fourth]];
    tabbarController.implementationDelegate = tabbarController;
    tabbarController.delegate = self;
    
    self.navigationController.navigationBarHidden = YES;
    
    
    //
    //  in the app delegate set the tabbar controller as the
    //  currently working tabbar controller
    //
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setCurrentCustomTabbarController:tabbarController];
    
    if(initialSelectedTabbarIndex != CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX)
    {
        //
        //  make a pending block which will
        //  select the initial selected view controller
        //
        RSCustomTabbarPendingBlock pendingBlock = ^{
            [tabbarController setSelectedViewCotnrollerAtIndex:initialSelectedTabbarIndex];
        };
        
        
        //  do it manually
        if(![tabbarController isViewLoaded])
        {
            //
            //  view of the tabbar is not loaded yet
            //  so just add a pending block
            //
            [tabbarController setShouldSelectDefaultViewController:NO];
            [tabbarController addPendingBlockIntendedToBeExecutedAfterViewDidLoad:pendingBlock];
            
        }
        else
        {
            //
            //  view of the tabbar is already loaded
            //  so execute the pending block by yourself
            //
            //  this case is not gonna be occur, unless you
            //  cache the tabbar controller or used it more than once
            //
            pendingBlock();
        }
    }
    else
    {
        //  just let it go :P
        [tabbarController setShouldSelectDefaultViewController:YES];
    }
    
    [self.navigationController pushViewController:tabbarController animated:YES];
}

-(void)showOnDemo2
{
    UIStoryboard *childsStory = [UIStoryboard storyboardWithName:@"childs" bundle:[NSBundle mainBundle]];
    
    UIViewController *first = [childsStory instantiateViewControllerWithIdentifier:@"firstVC"],
    *second = [childsStory instantiateViewControllerWithIdentifier:@"secondVC"],
    *third = [childsStory instantiateViewControllerWithIdentifier:@"thirdVC"],
    *fourth = [childsStory instantiateViewControllerWithIdentifier:@"fourthVC"];
    
    UIStoryboard *tabbarStory = [UIStoryboard storyboardWithName:@"demo2" bundle:[NSBundle mainBundle]];
    Demo2TabbarController *tabbarController = [tabbarStory instantiateInitialViewController];
    
    
    [tabbarController setViewControllers:@[first, second, third, fourth]];
    tabbarController.implementationDelegate = tabbarController;
    tabbarController.delegate = self;
    
    self.navigationController.navigationBarHidden = YES;
    
    
    //
    //  in the app delegate set the tabbar controller as the
    //  currently working tabbar controller
    //
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setCurrentCustomTabbarController:tabbarController];
    
    if(initialSelectedTabbarIndex != CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX)
    {
        //
        //  make a pending block which will
        //  select the initial selected view controller
        //
        RSCustomTabbarPendingBlock pendingBlock = ^{
            [tabbarController setSelectedViewCotnrollerAtIndex:initialSelectedTabbarIndex];
        };
        
        
        //  do it manually
        if(![tabbarController isViewLoaded])
        {
            //
            //  view of the tabbar is not loaded yet
            //  so just add a pending block
            //
            [tabbarController setShouldSelectDefaultViewController:NO];
            [tabbarController addPendingBlockIntendedToBeExecutedAfterViewDidLoad:pendingBlock];
            
        }
        else
        {
            //
            //  view of the tabbar is already loaded
            //  so execute the pending block by yourself
            //
            //  this case is not gonna be occur, unless you
            //  cache the tabbar controller or used it more than once
            //
            pendingBlock();
        }
    }
    else
    {
        //  just let it go :P
        [tabbarController setShouldSelectDefaultViewController:YES];
    }
    
    [self.navigationController pushViewController:tabbarController animated:YES];
}

-(void)showOnDemo3
{
    UIStoryboard *childsStory = [UIStoryboard storyboardWithName:@"childs" bundle:[NSBundle mainBundle]];
    
    UIViewController *first = [childsStory instantiateViewControllerWithIdentifier:@"firstVC"],
    *second = [childsStory instantiateViewControllerWithIdentifier:@"secondVC"],
    *third = [childsStory instantiateViewControllerWithIdentifier:@"thirdVC"];
    
    UIStoryboard *tabbarStory = [UIStoryboard storyboardWithName:@"demo3" bundle:[NSBundle mainBundle]];
    Demo3TabbarController *tabbarController = [tabbarStory instantiateInitialViewController];
    
    [tabbarController setViewControllers:@[first, second, third]];
    tabbarController.implementationDelegate = tabbarController;
    tabbarController.delegate = self;
    
    self.navigationController.navigationBarHidden = YES;
    
    
    //
    //  in the app delegate set the tabbar controller as the
    //  currently working tabbar controller
    //
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setCurrentCustomTabbarController:tabbarController];
    
    
    if(initialSelectedTabbarIndex != CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX)
    {
        //
        //  make a pending block which will
        //  select the initial selected view controller
        //
        RSCustomTabbarPendingBlock pendingBlock = ^{
            [tabbarController setSelectedViewCotnrollerAtIndex:initialSelectedTabbarIndex];
        };
        
        
        //  do it manually
        if(![tabbarController isViewLoaded])
        {
            //
            //  view of the tabbar is not loaded yet
            //  so just add a pending block
            //
            [tabbarController setShouldSelectDefaultViewController:NO];
            [tabbarController addPendingBlockIntendedToBeExecutedAfterViewDidLoad:pendingBlock];
            
        }
        else
        {
            //
            //  view of the tabbar is already loaded
            //  so execute the pending block by yourself
            //
            //  this case is not gonna be occur, unless you
            //  cache the tabbar controller or used it more than once
            //
            pendingBlock();
        }
    }
    else
    {
        //  just let it go :P
        [tabbarController setShouldSelectDefaultViewController:YES];
    }
    
    [self.navigationController pushViewController:tabbarController animated:YES];
}

-(void)showOnDemo4
{

    UIStoryboard *tabbarStory = [UIStoryboard storyboardWithName:@"demo4" bundle:[NSBundle mainBundle]];
    Demo4TabbarController *tabbarController = [tabbarStory instantiateInitialViewController];
    
    tabbarController.implementationDelegate = tabbarController;
    tabbarController.delegate = self;

    self.navigationController.navigationBarHidden = YES;

    
    //
    //  in the app delegate set the tabbar controller as the
    //  currently working tabbar controller
    //
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setCurrentCustomTabbarController:tabbarController];
    
    
    [self.navigationController pushViewController:tabbarController animated:YES];
}

-(void)showOnDemo5
{
    UIStoryboard *tabbarStory = [UIStoryboard storyboardWithName:@"demo5" bundle:[NSBundle mainBundle]];
    Demo5TabbarController *tabbarController = [tabbarStory instantiateInitialViewController];
    
    //
    //  we haven't configured the delegate implementation yet
    //
    //tabbarController.implementationDelegate = tabbarController;
    //tabbarController.delegate = self;
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setCurrentCustomTabbarController:tabbarController];
    
    [self.navigationController pushViewController:tabbarController animated:YES];
}

#pragma mark CustomTabbarDelegate
- (void)customTabbarControllerViewDidLoaded:(RSCustomTabbarController *)tabBarController
{
    NSLog(@"We are just confirmed that, our default custom tabbar is been loaded");
}

@end
