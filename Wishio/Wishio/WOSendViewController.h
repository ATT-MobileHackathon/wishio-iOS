//
//  WOSendViewController.h
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WOFundTableViewCell;
@class WOFund;

@interface WOSendViewController : UIViewController
@property (assign, nonatomic) CGFloat initialY;
@property (strong, nonatomic) WOFundTableViewCell *fundCell;
@property (strong, nonatomic) WOFund *fund;
- (void)getScreenshot;
@end
