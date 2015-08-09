//
//  WOUser.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOUser.h"

@implementation WOUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"imageURL" : @"image"
             };
}

+ (NSValueTransformer *)imageURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
