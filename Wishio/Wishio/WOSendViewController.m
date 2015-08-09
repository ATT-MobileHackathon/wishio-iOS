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
#import "UIColor+WOColors.h"
#import "UIView+WOAdditions.h"
#import "WOConstants.h"
#import "WOFundTableViewCell.h"
#import "WOOperations.h"

@interface WOSendViewController ()
@property (strong, nonatomic) UIButton *dismissButton;
@property (strong, nonatomic) UIImageView *screenshot;
@property (strong, nonatomic) UIImageView *blurView;

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *sendButton;

@end

static const CGFloat DAMPING_FACTOR = 0.70f;

@implementation WOSendViewController

- (instancetype)init {
    if (self = [super init]) {
        self.dismissButton = [[UIButton alloc] init];
        [self.dismissButton setSize:CGSizeMake(BARBUTTON_SIZE, BARBUTTON_SIZE)];
        [self.dismissButton setX:2.f]; //align with cell padding
        [self.dismissButton addTarget:self action:@selector(_dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        FAKIcon *closeIcon = [FAKIonIcons androidCloseIconWithSize:BARBUTTON_ICON_SIZE];
        [closeIcon setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [self.dismissButton setImage:[closeIcon imageWithSize:CGSizeMake(BARBUTTON_ICON_SIZE, BARBUTTON_ICON_SIZE)]
                            forState:UIControlStateNormal];
        
        self.textField = [[UITextField alloc] init];
        self.textField.backgroundColor = [UIColor whiteColor];
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.textField.font = [UIFont systemFontOfSize:14.f];
        self.textField.placeholder = @"          $$";
        self.textField.layer.cornerRadius = 3.f;
        
        self.sendButton = [[UIButton alloc] init];
        self.sendButton.backgroundColor = [UIColor lightGreenColor];
        self.sendButton.layer.cornerRadius = 3.f;
        [self.sendButton setTitle:@"Send" forState:UIControlStateNormal];
        self.sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        [self.sendButton addTarget:self action:@selector(_pressedDone) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.screenshot];
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.fundCell];
    [self.view addSubview:self.dismissButton];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.sendButton];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self _placeCloseButtonAboveView];
    [self _positionActionsBelowView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _placeCloseButtonAboveView];
    [self _positionActionsBelowView];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.25f animations:^{
        self.blurView.alpha = 1;
    }];
    [UIView animateWithDuration:0.50f delay:0 usingSpringWithDamping:DAMPING_FACTOR initialSpringVelocity:1 options:0 animations:^{
        [self.fundCell centerVertically];
        [self.fundCell setY:CGRectGetMinY(self.fundCell.frame)-50.f]; // lol jesus christ
        self.fundCell.sendMoneyButton.alpha = 0;
        [self _placeCloseButtonAboveView];
        [self _positionActionsBelowView];
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
    [self _addBlockViewsToScreenshot:self.screenshot];
}

- (void)_setupBlurView
{
    UIImage *blurredImage = [self.screenshot.image blurredImageWithRadius:10.f iterations:2 tintColor:nil];
    self.blurView = [[UIImageView alloc] initWithImage:blurredImage];
    [self.blurView setFrame:self.screenshot.frame];
    self.blurView.alpha = 0;
    
    [self _addBlockViewsToScreenshot:self.blurView];
    
    UIView *darkTint = [[UIView alloc] initWithFrame:self.blurView.bounds];
    darkTint.backgroundColor = [UIColor colorWithWhite:0 alpha:0.40];
    [self.blurView addSubview:darkTint];
}

- (void)_addBlockViewsToScreenshot:(UIView *)screenshot {
    UIView *blockingView = [[UIView alloc] init];
    blockingView.backgroundColor = self.fundCell.backgroundColor;
    [blockingView setFrame:self.fundCell.frame];
    [blockingView setHeight:CGRectGetHeight(blockingView.frame)];
    [screenshot addSubview:blockingView];
    
    UIView *navbar = [[UIView alloc] init];
    [navbar setWidth:CGRectGetWidth(screenshot.frame)];
    [navbar setHeight:NAVBAR_HEIGHT];
    navbar.backgroundColor = [UIColor mainColor];
    [screenshot addSubview:navbar];
}

- (void)_placeCloseButtonAboveView {
    [self.dismissButton setY:CGRectGetMinY(self.fundCell.frame) - CGRectGetHeight(self.dismissButton.frame)];
}

- (void)_positionActionsBelowView {
    [self.textField setWidth:100.f];
    [self.textField setHeight:40.f];
    [self.sendButton setWidth:100.f];
    [self.sendButton setHeight:40.f];
    [self.textField setX:CGRectGetMidX(self.view.frame)-CGRectGetWidth(self.textField.frame)-5.f];
    [self.textField setY:CGRectGetMaxY(self.fundCell.frame)+5.f];
    [self.sendButton setX:CGRectGetMidX(self.view.frame)+5.f];
    [self.sendButton setY:CGRectGetMaxY(self.fundCell.frame)+5.f];
}

- (void)_pressedDone {
    [self.sendButton setTitle:@"Sending..." forState:UIControlStateNormal];
    [self.textField resignFirstResponder];
    
    [WOOperations sendMoneyToFund:self.fund amount:[self.textField.text intValue]*100 success:^{
        self.fund.currentFunding += [self.textField.text intValue]*100;
        self.fund.funderCount += 1;
        [self _dismissSelf];
    } failure:nil];
}

- (void)_dismissSelf {
    [self.textField resignFirstResponder];
    [UIView animateWithDuration:0.25f animations:^{
        self.blurView.alpha = 0;
    }];
    [UIView animateWithDuration:0.50f delay:0 usingSpringWithDamping:DAMPING_FACTOR initialSpringVelocity:1 options:0 animations:^{
        [self.fundCell setY:self.initialY];
        self.fundCell.sendMoneyButton.alpha = 1;
        [self _placeCloseButtonAboveView];
        self.dismissButton.alpha = 0;
        [self _positionActionsBelowView];
        self.textField.alpha = 0;
        self.sendButton.alpha = 0;
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

@end
