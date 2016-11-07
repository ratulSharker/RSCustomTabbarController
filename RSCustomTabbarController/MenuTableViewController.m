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
#import "RSCustomTabbarController.h"
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
    NSString *menuDataFilePath = [[NSBundle mainBundle] pathForResource:@"MenuData" ofType:@"plist"];
    menuData = [NSArray arrayWithContentsOfFile:menuDataFilePath];
    
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
    [self showDemoWithTabbarStoryboardFile:@"demo1"
         childViewControllerStoryboardName:@"childs"
                                childVCSID:@[@"firstVC",
                                             @"secondVC",
                                             @"thirdVC",
                                             @"fourthVC"]];
}

-(void)showOnDemo2
{
    [self showDemoWithTabbarStoryboardFile:@"demo2"
         childViewControllerStoryboardName:@"childs"
                                childVCSID:@[@"firstVC",
                                             @"secondVC",
                                             @"thirdVC",
                                             @"fourthVC"]];
}

-(void)showOnDemo3
{
    [self showDemoWithTabbarStoryboardFile:@"demo3"
         childViewControllerStoryboardName:@"childs"
                                childVCSID:@[@"firstVC",
                                             @"secondVC",
                                             @"thirdVC"]];
}

-(void)showOnDemo4
{
    //
    //  this is set so that, no default view controller is selected by the next function call
    //
    initialSelectedTabbarIndex = CUSTOM_TABBAR_INITIAL_VIEWCONTROLLER_INDEX;
    
    [self showDemoWithTabbarStoryboardFile:@"demo4"
         childViewControllerStoryboardName:nil
                                childVCSID:nil];
}

-(void)showOnDemo5
{
    [self showDemoWithTabbarStoryboardFile:@"demo5"
         childViewControllerStoryboardName:@"demo5"
                                childVCSID:@[@"firstVC",
                                             @"secondVC",
                                             @"thirdVC",
                                             @"fourthVC"]];
}

#pragma mark CustomTabbarDelegate
- (void)customTabbarControllerViewDidLoaded:(RSCustomTabbarControllerBasic *)tabBarController
{
    NSLog(@"We are just confirmed that, our default custom tabbar is been loaded");
}

#pragma mark private helper method
-(NSArray<UIViewController*>*)createViewControllerFromStoryboardFile:(NSString*)fileName
                                                   viewControllerArr:(NSArray<NSString*>*)viewControllerIDs
{
    if(!fileName || fileName.length == 0)
    {
        return @[];
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:fileName bundle:[NSBundle mainBundle]];
    NSMutableArray<UIViewController*> *vcs = [[NSMutableArray alloc] init];
    
    for(NSString *viewControllerId in viewControllerIDs)
    {
        [vcs addObject:[storyboard instantiateViewControllerWithIdentifier:viewControllerId]];
    }
    
    return [NSArray arrayWithArray:vcs];
}

-(void)showDemoWithTabbarStoryboardFile:(NSString*)tabbarStoryboardFile
      childViewControllerStoryboardName:(NSString*)childStoryboardName
                             childVCSID:(NSArray<NSString*>*)childViewControllersID
{
    NSArray <UIViewController*>*childVCs = [self createViewControllerFromStoryboardFile:childStoryboardName
                                                                      viewControllerArr:childViewControllersID];
    //  initiating tabbar controller
    UIStoryboard *tabbarStory = [UIStoryboard storyboardWithName:tabbarStoryboardFile bundle:[NSBundle mainBundle]];
    RSCustomTabbarController *tabbarController = [tabbarStory instantiateInitialViewController];
    //  setting some implementation
    [tabbarController setViewControllers:childVCs];
    tabbarController.implementationDelegate = (id<RSCustomTabbarImplementationDelegate>)tabbarController;
    tabbarController.delegate = self;
    //  hiding the navigation controller
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
@end
