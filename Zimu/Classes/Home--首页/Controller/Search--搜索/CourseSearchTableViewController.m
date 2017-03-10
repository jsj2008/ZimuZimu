//
//  CourseSearchTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/1.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CourseSearchTableViewController.h"
#import "MJRefresh.h"
#import "CourseTableViewCell.h"

static NSString *courseIdentifier = @"courseCell";
@interface CourseSearchTableViewController ()

@end

@implementation CourseSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerCells];
    
    [self setupMJRefreshing];
}

- (void)registerCells{
    [self.tableView registerNib:[UINib nibWithNibName:@"CourseTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:courseIdentifier];
}

- (void)setupMJRefreshing{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}
- (void)refresh{
    __weak CourseSearchTableViewController *weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:1.5f repeats:NO block:^(NSTimer * _Nonnull timer) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:courseIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

@end
