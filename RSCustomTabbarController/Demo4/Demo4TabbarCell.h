//
//  Demo4TabbarCell.h
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 10/8/16.
//  Copyright © 2016 funtoos. All rights reserved.
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

@class Demo4TabbarCell;

@protocol Demo4TabbarCellDelegate <NSObject>

-(void)crossPressedForDemo4TabbarCell:(Demo4TabbarCell*)cell;

@end


@interface Demo4TabbarCell : UICollectionViewCell

@property IBOutlet UIImageView *mViewImageView;
@property IBOutlet UILabel *mViewLabel;
@property id<Demo4TabbarCellDelegate> delegate;


-(void)setNormalOrSelectedImage:(BOOL)isNormal;

@end
