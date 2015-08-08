//
//  WOFund.h
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "Mantle.h"
@class WOProduct;
@class WOUser;
@interface WOFund : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) NSInteger currentFunding;
@property (assign, nonatomic) NSInteger funderCount;
@property (strong, nonatomic) WOProduct *product;
@property (strong, nonatomic) WOUser *user;

- (NSString *)currentFundingString;

@end
