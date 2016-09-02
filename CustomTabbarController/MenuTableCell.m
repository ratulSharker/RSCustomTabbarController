//
//  MenuTableCell.m
//  CustomTabbarController
//
//  Created by Ratul Sharker on 9/2/16.
//  Copyright © 2016 funtoos. All rights reserved.
//

#import "MenuTableCell.h"

@implementation MenuTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark IBAction
- (IBAction)onStepperValueChanged:(UIStepper*)sender
{
    self.stepperStatusLabel.text = [NSString stringWithFormat:@"initial vc %d/%d", (int)sender.value, (int)sender.maximumValue];
}


@end
