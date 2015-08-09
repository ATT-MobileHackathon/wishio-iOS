//
//  WOFundTableViewCell.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOFundTableViewCell.h"

#import "FontAwesomeKit.h"

#import "UIColor+WOColors.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+WOAdditions.h"
#import "WOConstants.h"
#import "WOFund.h"
#import "WOProduct.h"
#import "WOUser.h"

@interface WOFundTableViewCell ()
@property UIImageView *userProfileImageView;
@property UILabel *usernameLabel;
@property UILabel *contributersLabel;

@property UILabel *productName;
@property UIImageView *productImageView;

@property UIView *progressBar;
@property UIView *currentProgressView;

@property UILabel *currentRaisedLabel;
@property UILabel *priceLabel;

@property UIView *bottomDivider;

@property CGFloat progress;
@end

static const CGFloat PRODUCT_IMAGE_SIZE = 100.f;

@implementation WOFundTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        self.userProfileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, PROFILE_SIZE, PROFILE_SIZE)];
        self.userProfileImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.userProfileImageView.clipsToBounds = YES;
        self.userProfileImageView.layer.cornerRadius = PROFILE_SIZE / 2;
        self.userProfileImageView.backgroundColor = [UIColor lighterGrayColor];
        [self.contentView addSubview:self.userProfileImageView];
        
        self.usernameLabel = [[UILabel alloc] init];
        self.usernameLabel.font = [UIFont boldSystemFontOfSize:14.f];
        self.usernameLabel.textColor = [UIColor primaryTextColor];
        self.usernameLabel.numberOfLines = 1;
        self.usernameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.usernameLabel];
        
        self.contributersLabel = [[UILabel alloc] init];
        self.contributersLabel.font = [UIFont systemFontOfSize:12.f];
        self.contributersLabel.textColor = [UIColor secondaryTextColor];
        self.contributersLabel.numberOfLines = 1;
        self.contributersLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.contributersLabel];
        
        self.productName = [[UILabel alloc] init];
        self.productName.font = [UIFont systemFontOfSize:16.f];
        self.productName.numberOfLines = 0;
        self.productName.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.productName];
        
        self.productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, PRODUCT_IMAGE_SIZE, PRODUCT_IMAGE_SIZE)];
        self.productImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.productImageView.clipsToBounds = YES;
        self.productImageView.layer.cornerRadius = 5.f;
        self.productImageView.backgroundColor = [UIColor lighterGrayColor];
        [self.contentView addSubview:self.productImageView];
        
        self.progressBar = [[UIView alloc] init];
        self.progressBar.backgroundColor = [UIColor lighterGrayColor];
        self.progressBar.clipsToBounds = YES;
        self.progressBar.layer.cornerRadius = 2.f;
        [self.progressBar setWidth:4.f];
        [self.contentView addSubview:self.progressBar];
        
        self.currentProgressView = [[UIView alloc] init];
        self.currentProgressView.backgroundColor = [UIColor lightGreenColor];
        [self.progressBar addSubview:self.currentProgressView];
        [self.currentProgressView fillWidth];
        
        self.currentRaisedLabel = [[UILabel alloc] init];
        self.currentRaisedLabel.font = [UIFont boldSystemFontOfSize:25.f];
        self.currentRaisedLabel.textColor = [UIColor lightGreenColor];
        self.currentRaisedLabel.numberOfLines = 1;
        [self.contentView addSubview:self.currentRaisedLabel];
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.font = [UIFont boldSystemFontOfSize:14.f];
        self.priceLabel.numberOfLines = 1;
        [self.contentView addSubview:self.priceLabel];
        
        self.sendMoneyButton = [[UIButton alloc] init];
        [self.sendMoneyButton setSize:CGSizeMake(80.f, 30.f)];
        FAKIcon *moneyIcon = [FAKIonIcons socialUsdIconWithSize:14.f];
        [moneyIcon setAttributes:@{NSForegroundColorAttributeName:[UIColor lightGreenColor]}];
        [self.sendMoneyButton setImage:[moneyIcon imageWithSize:CGSizeMake(14.f, 14.f)]
                              forState:UIControlStateNormal];
        [self.sendMoneyButton setTitle:@"Send" forState:UIControlStateNormal];
        [self.sendMoneyButton setTitleColor:[UIColor lightGreenColor] forState:UIControlStateNormal];
        self.sendMoneyButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        self.sendMoneyButton.layer.cornerRadius = 3.f;
        self.sendMoneyButton.layer.borderWidth = 1.f;
        self.sendMoneyButton.layer.borderColor = [UIColor lightGreenColor].CGColor;
        [self insertSubview:self.sendMoneyButton atIndex:0];

        self.bottomDivider = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, DIVIDER_HEIGHT())];
        self.bottomDivider.backgroundColor = [UIColor borderColor];
        [self.contentView addSubview:self.bottomDivider];
    }
    return self;
}

- (void)dealloc {
    [self.userProfileImageView cancelImageRequestOperation];
    self.userProfileImageView.image = nil;
    [self.productImageView cancelImageRequestOperation];
    self.productImageView.image = nil;
}

- (void)prepareForReuse {
    [self.userProfileImageView cancelImageRequestOperation];
    self.userProfileImageView.image = nil;
    [self.productImageView cancelImageRequestOperation];
    self.productImageView.image = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.userProfileImageView setX:SIDE_MARGIN];
    [self.userProfileImageView setY:VERTICAL_MARGIN];
    
    [self.usernameLabel setX:CGRectGetMaxX(self.userProfileImageView.frame) + TEXT_MARGIN];
    [self.usernameLabel setY:CGRectGetMinY(self.userProfileImageView.frame)];
    [self.usernameLabel fillWidthWithMargin:TEXT_MARGIN];
    [self.usernameLabel setHeight:[self.usernameLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].height];
    
    [self.contributersLabel sizeToFit];
    [self.contributersLabel setHeight:CGRectGetHeight(self.usernameLabel.frame)];
    [self.contributersLabel setY:VERTICAL_MARGIN];
    [self.contributersLabel alignRightWithMargin:TEXT_MARGIN];
    [self.usernameLabel fillWidthWithMargin:TEXT_MARGIN + CGRectGetWidth(self.contributersLabel.frame)];
    
    [self.productName setX:CGRectGetMinX(self.usernameLabel.frame)];
    [self.productName setY:CGRectGetMaxY(self.usernameLabel.frame) + TEXT_MARGIN/2];
    [self.productName fillWidthWithMargin:TEXT_MARGIN];
    CGFloat height = [self.productName sizeThatFits:CGSizeMake(CGRectGetWidth(self.productName.frame), CGFLOAT_MAX)].height;
    [self.productName setHeight:height];
    
    [self.productImageView setX:CGRectGetMinX(self.usernameLabel.frame)];
    [self.productImageView setY:CGRectGetMaxY(self.productName.frame) + TEXT_MARGIN];
    
    [self.progressBar setX:CGRectGetMaxX(self.productImageView.frame) + TEXT_MARGIN];
    [self.progressBar setY:CGRectGetMinY(self.productImageView.frame)];
    [self.progressBar setHeight:CGRectGetHeight(self.productImageView.frame)];
    
    [self.currentProgressView setHeight:CGRectGetHeight(self.progressBar.frame) * self.progress];
    [self.currentProgressView alignBottomWithMargin:0];
    
    [self.currentRaisedLabel sizeToFit];
    [self.currentRaisedLabel setX:CGRectGetMaxX(self.progressBar.frame) + TEXT_MARGIN];
    [self.currentRaisedLabel setY:CGRectGetMidY(self.progressBar.frame) - CGRectGetHeight(self.currentRaisedLabel.frame)];
    
    [self.priceLabel sizeToFit];
    [self.priceLabel setX:CGRectGetMinX(self.currentRaisedLabel.frame)];
    [self.priceLabel setY:CGRectGetMaxY(self.currentRaisedLabel.frame)];
    
    [self.sendMoneyButton alignRightWithMargin:TEXT_MARGIN];
    [self.sendMoneyButton alignBottomWithMargin:TEXT_MARGIN];
    
    [self.bottomDivider setX:CGRectGetMinX(self.usernameLabel.frame)];
    [self.bottomDivider setY:CGRectGetMaxY(self.productImageView.frame) + VERTICAL_MARGIN];
    [self.bottomDivider fillWidth];
    
    [self setHeight:CGRectGetMaxY(self.bottomDivider.frame)];
}

#pragma mark - Public Methods

- (void)setupWithFund:(WOFund *)fund
{
    [self.userProfileImageView setImageWithURL:fund.user.imageURL];
    self.usernameLabel.text = fund.user.name;
    self.contributersLabel.text = [NSString stringWithFormat:@"%d contributors", (int)fund.funderCount];
    if (fund.funderCount == 1) {
        self.contributersLabel.text = [self.contributersLabel.text substringToIndex:[self.contributersLabel.text length]-1];
    }
    self.productName.text = fund.product.name;
    [self.productImageView setImageWithURL:fund.product.imageURL];
    if (fund) {
        self.progress = (CGFloat) fund.currentFunding / fund.product.price;
    }
    self.currentRaisedLabel.text = [fund currentFundingString];
    self.priceLabel.text = [NSString stringWithFormat:@"of %@", [fund.product priceString]];
    
    [self layoutSubviews];
}

+ (CGFloat)heightGivenFund:(WOFund *)fund widthConstraint:(CGFloat)width
{
    static WOFundTableViewCell *cell;
    if (!cell) {
        cell = [[WOFundTableViewCell alloc] init];
    }
    [cell setWidth:width];
    [cell setupWithFund:fund];
    return CGRectGetHeight(cell.frame);
}

@end
