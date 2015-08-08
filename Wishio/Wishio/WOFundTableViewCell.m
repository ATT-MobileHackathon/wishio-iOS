//
//  WOFundTableViewCell.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOFundTableViewCell.h"

#import "UIColor+WOColors.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+WOAdditions.h"
#import "WOConstants.h"

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.userProfileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, PROFILE_SIZE, PROFILE_SIZE)];
        self.userProfileImageView.clipsToBounds = YES;
        self.userProfileImageView.layer.cornerRadius = PROFILE_SIZE / 2;
        self.userProfileImageView.backgroundColor = [UIColor lighterGrayColor];
        [self.contentView addSubview:self.userProfileImageView];
        
        self.usernameLabel = [[UILabel alloc] init];
        self.usernameLabel.font = [UIFont boldSystemFontOfSize:14.f];
        self.usernameLabel.numberOfLines = 1;
        self.usernameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.usernameLabel];
        
        self.bottomDivider = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, DIVIDER_HEIGHT())];
        self.bottomDivider.backgroundColor = [UIColor borderColor];
        [self.contentView addSubview:self.bottomDivider];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)prepareForReuse {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.userProfileImageView setX:SIDE_MARGIN];
    [self.userProfileImageView setY:VERTICAL_MARGIN];
    
    [self.usernameLabel setHeight:CGRectGetHeight(self.userProfileImageView.frame)];
    [self.usernameLabel setX:CGRectGetMaxX(self.userProfileImageView.frame) + TEXT_MARGIN];
    [self.usernameLabel setY:CGRectGetMinY(self.userProfileImageView.frame)];
    [self.usernameLabel fillWidth];
    self.usernameLabel.text = @"Test Username";
    
    [self.bottomDivider setX:CGRectGetMinX(self.usernameLabel.frame)];
    [self.bottomDivider fillWidth];
    [self.bottomDivider alignBottomWithMargin:0];
}

#pragma mark - Public Methods

- (void)setupWithFund:(id)fund
{
    
}

+ (CGFloat)height
{
    return VERTICAL_MARGIN + PROFILE_SIZE + VERTICAL_MARGIN;
}

@end
