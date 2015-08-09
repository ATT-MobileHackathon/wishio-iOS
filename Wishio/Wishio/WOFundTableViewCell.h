//
//  WOFundTableViewCell.h
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WOFund.h"

@interface WOFundTableViewCell : UITableViewCell
@property UIButton *sendMoneyButton;
- (void)setupWithFund:(WOFund *)fund;
+ (CGFloat)heightGivenFund:(WOFund *)fund widthConstraint:(CGFloat)width;
@end
