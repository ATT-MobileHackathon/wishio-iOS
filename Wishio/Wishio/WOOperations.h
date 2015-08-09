//
//  WOOperations.h
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WOFund;

@interface WOOperations : NSObject

+ (void)requestFeedWithParameters:(NSDictionary *)parameters
                          success:(void (^)(NSArray *))success
                          failure:(void (^)(NSString *message))failure;

+ (void)sendMoneyToFund:(WOFund *)fund
                 amount:(NSInteger)amount
                success:(void(^)())success
                failure:(void (^)(NSString *message))failure;

@end
