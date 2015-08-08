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
#import "WOSendViewController.h"

@interface WOHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *feedItems;
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation WOHomeViewController

#pragma mark - View Controller LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _setupView];
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
    return [self.feedItems count] + 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WOFund *fund = nil; //self.feedItems[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    WOFundTableViewCell *cellCopy = [[WOFundTableViewCell alloc] init];
    CGFloat screenY = [tableView convertPoint:cell.frame.origin toView:nil].y;
    [cellCopy setY:screenY];
    [cellCopy setWidth:CGRectGetWidth(tableView.frame)];
    [cellCopy setupWithFund:fund];
    
    WOSendViewController *controller = [[WOSendViewController alloc] init];
    controller.initialY = CGRectGetMinY(cellCopy.frame);
    controller.fundCell = cellCopy;
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
}

#pragma mark - Lazy Instantiation

- (NSMutableArray *)feedItems {
    if (!_feedItems) {
        _feedItems = [[NSMutableArray alloc] init];
    }
    return _feedItems;
}

@end
