//
//  WOSendViewController.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOSendViewController.h"

#import "FXBlurView.h"

@interface WOSendViewController ()
@property (strong, nonatomic) UIImageView *screenshot;
@property (strong, nonatomic) FXBlurView *blurView;
@end

@implementation WOSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.screenshot];
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.fundCell];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
    [self.screenshot addSubview:blockingView];
}

- (void)_setupBlurView
{
    self.blurView = [[FXBlurView alloc] init];
    [self.blurView setFrame:self.screenshot.frame];
    self.blurView.tintColor = [UIColor blackColor];
    self.blurView.blurRadius = 10.f;
    self.blurView.dynamic = NO;
}

@end
