//
//  WOSendViewController.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOSendViewController.h"

#import "FontAwesomeKit.h"
#import "FXBlurView.h"
#import "UIView+WOAdditions.h"
#import "WOConstants.h"

@interface WOSendViewController ()
@property (strong, nonatomic) UIButton *dismissButton;
@property (strong, nonatomic) UIImageView *screenshot;
@property (strong, nonatomic) UIImageView *blurView;
@end

static const CGFloat DAMPING_FACTOR = 0.70f;

@implementation WOSendViewController

- (instancetype)init {
    if (self = [super init]) {
        self.dismissButton = [[UIButton alloc] init];
        [self.dismissButton setSize:CGSizeMake(BARBUTTON_SIZE, BARBUTTON_SIZE)];
        [self.dismissButton addTarget:self action:@selector(_pressedDismiss:) forControlEvents:UIControlEventTouchUpInside];
        FAKIcon *closeIcon = [FAKIonIcons androidCloseIconWithSize:BARBUTTON_ICON_SIZE];
        [closeIcon setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [self.dismissButton setImage:[closeIcon imageWithSize:CGSizeMake(BARBUTTON_ICON_SIZE, BARBUTTON_ICON_SIZE)]
                            forState:UIControlStateNormal];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.screenshot];
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.fundCell];
    [self.view addSubview:self.dismissButton];
}

- (void)viewWillLayoutSubviews {
    [self _placeCloseButtonAboveView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.30f animations:^{
        self.blurView.alpha = 1;
    }];
    [UIView animateWithDuration:0.50f delay:0 usingSpringWithDamping:DAMPING_FACTOR initialSpringVelocity:1 options:0 animations:^{
        [self.fundCell centerVertically];
        [self _placeCloseButtonAboveView];
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

- (void)_placeCloseButtonAboveView {
    [self.dismissButton setY:CGRectGetMinY(self.fundCell.frame) - CGRectGetHeight(self.dismissButton.frame)];
}

- (void)_pressedDismiss:(id)sender {
    
}

@end
