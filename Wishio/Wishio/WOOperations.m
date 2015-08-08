//
//  WOOperations.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOOperations.h"
#import "AFNetworking.h"

static const NSString * BASE_URL = @"";
static NSString * FEED_ENDPOINT = @"/feed";

@implementation WOOperations

- (void)requestFeedWithParameters:(NSDictionary *)parameters
                          success:(void (^)(NSArray *))success
                          failure:(void (^)(NSString *message))failure
{
    NSString *URL = [BASE_URL stringByAppendingString:FEED_ENDPOINT];
    [[AFHTTPRequestOperationManager manager] GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //parse
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(@"Could not retrieve feed");
        }
    }];
}

@end
