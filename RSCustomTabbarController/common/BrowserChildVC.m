//
//  BrowserChildVC.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/8/16.
//  Copyright © 2016 funtoos. All rights reserved.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "BrowserChildVC.h"

@interface BrowserChildVC ()<UITextFieldDelegate>

@end

@implementation BrowserChildVC
{
    
    IBOutlet UITextField *mViewAddressTextField;
    IBOutlet UIWebView *mViewWebView;
}


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

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self loadThePage:textField.text];
    
    
    //
    //  yes we handled it here :)
    //
    return YES;
}

#pragma mark IBAction
- (IBAction)onGoBtnPress:(id)sender
{
    [self loadThePage:mViewAddressTextField.text];
}


#pragma mark private method
-(void)loadThePage:(NSString*)siteUrl
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:siteUrl]];
    [mViewWebView loadRequest:request];
    
    [mViewAddressTextField resignFirstResponder];
}


@end
