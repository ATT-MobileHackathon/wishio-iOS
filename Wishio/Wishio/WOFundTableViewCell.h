//
//  WOFundTableViewCell.h
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOFundTableViewCell : UITableViewCell
- (void)setupWithFund:(id)fund;
+ (CGFloat)height;
@end
