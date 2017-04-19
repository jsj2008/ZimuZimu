//
//  EvaluationSearchTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/1.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EvaluationSearchTableViewController.h"
#import "MJRefresh.h"
#import "EvaluationTableViewCell.h"

static NSString *evaluationIdentifier = @"evaluationCell";

@interface EvaluationSearchTableViewController ()

@end

@implementation EvaluationSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerCells];
    
    [self setupMJRefreshing];
}

- (void)registerCells{
    [self.tableView registerClass:[EvaluationTableViewCell class] forCellReuseIdentifier:evaluationIdentifier];
}

- (void)setupMJRefreshing{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}
- (void)refresh{
    __weak EvaluationSearchTableViewController *weakSelf = self;
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
    EvaluationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluationIdentifier forIndexPath:indexPath];
    
    EvaluationCellLayout *evaluationCellLayout = [[EvaluationCellLayout alloc]init];
    cell.evaluationCellLayout = evaluationCellLayout;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

@end
