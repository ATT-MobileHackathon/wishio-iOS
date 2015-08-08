//
//  WOSendViewController.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOSendViewController.h"

#import "FXBlurView.h"
#import "UIView+WOAdditions.h"

@interface WOSendViewController ()
@property (strong, nonatomic) UIImageView *screenshot;
@property (strong, nonatomic) UIImageView *blurView;
@end

static const CGFloat DAMPING_FACTOR = 0.70f;

@implementation WOSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.screenshot];
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.fundCell];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.30f animations:^{
        self.blurView.alpha = 1;
    }];
    [UIView animateWithDuration:0.50f delay:0 usingSpringWithDamping:DAMPING_FACTOR initialSpringVelocity:1 options:0 animations:^{
        [self.fundCell centerVertically];
    } completion:nil];
}

#pragma mark - Public Methods

- (void)getScreenshot {
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGRect rec = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow drawViewHierarchyInRect:rec afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.screenshot = [[UIImageView alloc] initWithImage:image];
    [self _updateScreenshot];
    [self _setupBlurView];
}

#pragma mark - Private Methods

- (void)_updateScreenshot
{
    UIView *blockingView = [[UIView alloc] init];
    blockingView.backgroundColor = self.fundCell.backgroundColor;
    [blockingView setFrame:self.fundCell.frame];
    [blockingView setHeight:CGRectGetHeight(blockingView.frame)+21.f]; //some random adjustment...
    [self.screenshot addSubview:blockingView];
}

- (void)_setupBlurView
{
    UIImage *blurredImage = [self.screenshot.image blurredImageWithRadius:10.f iterations:2 tintColor:nil];
    self.blurView = [[UIImageView alloc] initWithImage:blurredImage];
    [self.blurView setFrame:self.screenshot.frame];
    self.blurView.alpha = 0;
    
    UIView *blockingView = [[UIView alloc] init];
    blockingView.backgroundColor = self.fundCell.backgroundColor;
    [blockingView setFrame:self.fundCell.frame];
    [blockingView setHeight:CGRectGetHeight(blockingView.frame)+21.f]; //some random adjustment...
    [self.blurView addSubview:blockingView];
    
    UIView *darkTint = [[UIView alloc] initWithFrame:self.blurView.bounds];
    darkTint.backgroundColor = [UIColor colorWithWhite:0 alpha:0.40];
    [self.blurView addSubview:darkTint];
}

@end
