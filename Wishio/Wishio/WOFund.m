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
             @"currentFunding" : @"currently_funded",
             @"funderCount" : @"total_funders",
             @"product" : @"item"
             };
}

#pragma mark - Public Methods

- (NSString *)currentFundingString {
    NSMutableString *result = [[NSMutableString alloc] init];
    [result setString:[NSString stringWithFormat:@"$%li", self.currentFunding]];
    [result insertString:@"." atIndex:[result length] - 2];
    return result;
}

@end
