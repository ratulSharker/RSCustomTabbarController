//
//  MenuTableCell.h
//  CustomTabbarController
//
//  Created by Ratul Sharker on 9/2/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIStepper *initialViewControllerSelectorStepper;
@property (strong, nonatomic) IBOutlet UILabel *stepperStatusLabel;


@end
