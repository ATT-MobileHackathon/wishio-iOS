//
//  WOFund.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOFund.h"

@implementation WOFund

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"fundId" : @"fund_id",
             @"currentFunding" : @"currently_funded",
             @"funderCount" : @"total_funders",
             @"product" : @"item"
             };
}

#pragma mark - Public Methods

- (NSString *)currentFundingString {
    if (self.currentFunding >= 10) {
        NSMutableString *result = [[NSMutableString alloc] init];
        [result setString:[NSString stringWithFormat:@"$%d", (int)self.currentFunding]];
        [result insertString:@"." atIndex:[result length] - 2];
        return result;
    }
    return [NSString stringWithFormat:@"$%d", (int)self.currentFunding];
}

@end
