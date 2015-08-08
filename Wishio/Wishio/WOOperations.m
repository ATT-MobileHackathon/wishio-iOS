//
//  WOOperations.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOOperations.h"

#import "AFNetworking.h"
#import "WOFund.h"
#import "WOProduct.h"
#import "WOUser.h"

static const NSString * BASE_URL = @"https://214b7bb7.ngrok.com";
static NSString * FEED_ENDPOINT = @"/funds/retrieve";

@implementation WOOperations

+ (void)requestFeedWithParameters:(NSDictionary *)parameters
                          success:(void (^)(NSArray *))success
                          failure:(void (^)(NSString *message))failure
{
    NSString *URL = [BASE_URL stringByAppendingString:FEED_ENDPOINT];
    [[AFHTTPRequestOperationManager manager] GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *funds = [[NSMutableArray alloc] init];
        NSArray *fundJSONs = responseObject[@"funds"];
        for (NSDictionary *fundJSON in fundJSONs) {
            WOFund *fund = [[WOFund alloc] init];
            fund.funderCount = (long)fundJSON[@"total_funders"];
            fund.currentFunding = (long)fundJSON[@"currently_funded"];
            
            NSDictionary *productJSON = fundJSON[@"item"];
            WOProduct *product = [[WOProduct alloc] init];
            product.name = productJSON[@"name"];
            product.imageURL = [NSURL URLWithString:productJSON[@"image"]];
            product.price = (long)productJSON[@"price"];
            
            NSDictionary *userJSON = fundJSON[@"user"];
            WOUser *user = [[WOUser alloc] init];
            user.name = userJSON[@"name"];
            user.imageURL = [NSURL URLWithString:userJSON[@"image"]];
            
            fund.product = product;
            fund.user = user;
            
            [funds addObject:fund];
        }
        if (success) {
            success(funds);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(@"Could not retrieve feed");
        }
    }];
}

@end
