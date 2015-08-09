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
#import "WOFund.h"
#import "WOFundTableViewCell.h"
#import "WOOperations.h"
#import "WOSendViewController.h"

@interface WOHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *feedItems;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation WOHomeViewController

#pragma mark - View Controller LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _setupView];
    [self _requestFeed];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - UITableViewDelegate / UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.feedItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOFund *fund = self.feedItems[indexPath.row];
    return [WOFundTableViewCell heightGivenFund:fund widthConstraint:CGRectGetWidth(tableView.frame)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifider = @"Feed cell";
    WOFundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifider];
    if (!cell) {
        cell = [[WOFundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifider];
        [cell setWidth:CGRectGetWidth(tableView.frame)];
    }
    WOFund *fund = self.feedItems[indexPath.row];
    [cell setupWithFund:fund];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WOFund *fund = self.feedItems[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    WOFundTableViewCell *cellCopy = [[WOFundTableViewCell alloc] init];
    CGFloat screenY = [tableView convertPoint:cell.frame.origin toView:nil].y;
    [cellCopy setY:screenY];
    [cellCopy setWidth:CGRectGetWidth(tableView.frame)];
    [cellCopy setupWithFund:fund];
    
    WOSendViewController *controller = [[WOSendViewController alloc] init];
    controller.initialY = CGRectGetMinY(cellCopy.frame);
    controller.fundCell = cellCopy;
    controller.fund = fund;
    [controller getScreenshot];
    
    [self.navigationController pushViewController:controller animated:NO];
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
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(_requestFeed) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] init];
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.tableView addSubview:self.activityIndicator];
    [self.activityIndicator centerHorizontally];
    [self.activityIndicator setY:20.f];
    [self.activityIndicator startAnimating];
}

- (void)_requestFeed {
    [WOOperations requestFeedWithParameters:nil success:^(NSArray *feedItems) {
        self.feedItems = feedItems;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        [self.activityIndicator stopAnimating];
    } failure:nil];
}

#pragma mark - Lazy Instantiation

- (NSArray *)feedItems {
    if (!_feedItems) {
        _feedItems = [[NSArray alloc] init];
    }
    return _feedItems;
}

@end
