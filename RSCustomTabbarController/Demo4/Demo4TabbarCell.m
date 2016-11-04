//
//  Demo4TabbarCell.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/8/16.
//  Copyright © 2016 funtoos. All rights reserved.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "Demo4TabbarCell.h"

@implementation Demo4TabbarCell

-(void)awakeFromNib
{
    [self setNormalImage];
}

#pragma mark IBActions
- (IBAction)onCrossBtnPressed:(id)sender
{
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(crossPressedForDemo4TabbarCell:)])
    {
        [self.delegate crossPressedForDemo4TabbarCell:self];
    }
    else
    {
        NSLog(@"delegate for Demo4Cell is not implemented");
    }
}


#pragma mark public method

-(void)setNormalOrSelectedImage:(BOOL)isSelected
{
    NSString *imgName;
    
    if(!isSelected)
    {
        imgName = @"browser_tab_normal";
    }
    else
    {
        imgName = @"browser_tab_selected";
    }
    
    self.mViewImageView.image = [[UIImage imageNamed:imgName] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 24, 0, 26)
                                                                             resizingMode:UIImageResizingModeStretch];
}
-(void)setSelectedImage
{
    
}

-(void)setNormalImage
{

}

@end
