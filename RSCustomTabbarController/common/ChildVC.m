//
//  ChildVC.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 8/30/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "ChildVC.h"
#import "AppDelegate.h"

@interface ChildVC ()

@end

@implementation ChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark IBAction
- (IBAction)onBottomSwitchValueChanged:(UISwitch*)sender
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    RSCustomTabbarController *tabbarController = [appDelegate getCurrentCustomTabbarController];
    [tabbarController setTabbarVisibility:sender.isOn animated:YES];
}

- (IBAction)backToDemoList:(UIButton*)sender
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UINavigationController *navController = [appDelegate getCurrentNavigationController];
    
    [navController popViewControllerAnimated:YES];
}


@end
