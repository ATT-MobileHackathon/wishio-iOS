//
//  WOFundTableViewCell.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOFundTableViewCell.h"

#import "UIImageView+AFNetworking.h"

@interface WOFundTableViewCell ()
@property UIImageView *userProfileImageView;
@property UILabel *usernameLabel;
@property UILabel *productName;
@property UIImage *productImageView;
@property UILabel *contributersLabel;
@property UIView *bottomDivider;
@end

@implementation WOFundTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)dealloc {
    
}

- (void)prepareForReuse {
    
}

- (void)layoutSubviews {
    
}

#pragma mark - Public Methods

- (void)setupWithFund:(id)fund
{
    
}

+ (CGFloat)height
{
    return 70.f;
}

@end
