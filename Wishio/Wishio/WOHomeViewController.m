//
//  WOViewController.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "WOHomeViewController.h"

#import "UIView+WOAdditions.h"
#import "WOConstants.h"
#import "WOFundTableViewCell.h"

@interface WOHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *feedItems;
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation WOHomeViewController

#pragma mark - View Controller LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self _setupView];
}

#pragma mark - UITableViewDelegate / UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.feedItems count] + 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WOFundTableViewCell heightGivenFund:nil widthConstraint:CGRectGetWidth(tableView.frame)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifider = @"Feed cell";
    WOFundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifider];
    if (!cell) {
        cell = [[WOFundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifider];
    }
    return cell;
}

#pragma mark - Private Methods

- (void)_setupView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [tableView setHeight:CGRectGetHeight(tableView.frame) - NAVBAR_HEIGHT];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - Lazy Instantiation

- (NSMutableArray *)feedItems {
    if (!_feedItems) {
        _feedItems = [[NSMutableArray alloc] init];
    }
    return _feedItems;
}

@end
