//
//  WOOnboardViewController.m
//  Wishio
//
//  Created by Zachary Liu on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOOnboardViewController.h"
#import "WOHomeViewController.h"
#import "MBProgressHUD.h"
#import "WOOperations.h"

@interface WOOnboardViewController () <UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;
//@property (nonatomic, strong) UILabel *label;
@end

@implementation WOOnboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 350, 50)];
//    self.label.text = @"Pinterest Username";
//    self.label.textColor = [UIColor blackColor];
//    [self.view addSubview:self.label];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 200, 350, 40)];
    self.textView.delegate = self;
    self.textView.text = @"Pinterest Username";
    self.textView.textAlignment = NSTextAlignmentCenter;
    [[self.textView layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.textView layer] setBorderWidth:1];
    [[self.textView layer] setCornerRadius:2];
    [self.textView setFont:[UIFont systemFontOfSize:22]];

    [self.view addSubview:self.textView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(submit)];
}

- (void)submit
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [WOOperations registration:@"April Yu" username:@"aprilyu" success:^{
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setInteger:1 forKey:@"user_id"];
            [defaults synchronize];
            [NSThread sleepForTimeInterval:1.0];
            [self loadHome];
        } failure:nil];
    });
}

- (void)loadHome
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        WOHomeViewController *rootViewController = [[WOHomeViewController alloc] init];
        [self.navigationController pushViewController:rootViewController animated:YES];
    });
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Pinterest Username"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Pinterest Username";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

@end
