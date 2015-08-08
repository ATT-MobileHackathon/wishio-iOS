//
//  WOProduct.h
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "Mantle.h"

@interface WOProduct : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger price;
@property (copy, nonatomic) NSURL *imageURL;

@end
