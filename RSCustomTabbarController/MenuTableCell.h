//
//  MenuTableCell.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 9/2/16.
//  Copyright © 2016 funtoos.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

@interface MenuTableCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIStepper *initialViewControllerSelectorStepper;
@property (strong, nonatomic) IBOutlet UILabel *stepperStatusLabel;


@end
