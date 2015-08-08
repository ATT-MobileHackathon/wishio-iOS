//
//  WOSendViewController.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOSendViewController.h"

@interface WOSendViewController ()
@property (strong, nonatomic) UIImageView *screenshot;
@end

@implementation WOSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.screenshot];
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
}

@end
