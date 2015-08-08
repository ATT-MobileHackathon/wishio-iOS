//
//  WOProduct.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOProduct.h"

@implementation WOProduct

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"imageURL" : @"image"
             };
}

+ (NSValueTransformer *)imageURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

#pragma mark - Public Methods

- (NSString *)priceString {
    NSMutableString *result = [[NSMutableString alloc] init];
    [result setString:[NSString stringWithFormat:@"$%li", self.price]];
    [result insertString:@"." atIndex:[result length] - 2];
    return result;
}

@end
