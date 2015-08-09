//
//  WOOnboardViewController.m
//  Wishio
//
//  Created by Zachary Liu on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOOnboardViewController.h"

#import "FontAwesomeKit.h"
#import "MBProgressHUD.h"
#import "UIColor+WOColors.h"
#import "WOConstants.h"
#import "WOHomeViewController.h"
#import "WOOperations.h"

@interface WOOnboardViewController ()
@property (nonatomic, strong) UITextField *textView;
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
    
    self.textView = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 350, 40)];
    self.textView.placeholder = @"@Pinterest Username";
    self.textView.textAlignment = NSTextAlignmentCenter;
    self.textView.backgroundColor = [UIColor lighterGrayColor];
    self.textView.autocorrectionType = UITextAutocorrectionTypeNo;
    [[self.textView layer] setCornerRadius:2];
    [self.textView setFont:[UIFont systemFontOfSize:22]];

    [self.view addSubview:self.textView];
    FAKIcon *doneIcon = [FAKIonIcons androidDoneIconWithSize:BARBUTTON_ICON_SIZE];
    [doneIcon setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImage *doneImage = [doneIcon imageWithSize:CGSizeMake(BARBUTTON_ICON_SIZE, BARBUTTON_ICON_SIZE)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithImage:doneImage
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(submit)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)submit
{
    [self.textView resignFirstResponder];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [WOOperations registration:@"John Don" username:self.textView.text success:^{
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setInteger:1 forKey:@"user_id"];
            [defaults synchronize];
            [NSThread sleepForTimeInterval:1.0];
            [self loadHome];
        } failure:^(NSString *message) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setInteger:1 forKey:@"user_id"];
            [defaults synchronize];
            [NSThread sleepForTimeInterval:1.0];
            [self loadHome];
        }];
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

@end
