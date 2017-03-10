//
//  BooksSearchTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/1.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BooksSearchTableViewController.h"
#import "MJRefresh.h"
#import "BooksTableViewCell.h"

static NSString *booksIdentifier = @"booksCell";
@interface BooksSearchTableViewController ()

@end

@implementation BooksSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerCells];
    
    [self setupMJRefreshing];
}

- (void)registerCells{
    [self.tableView registerNib:[UINib nibWithNibName:@"BooksTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:booksIdentifier];
}

- (void)setupMJRefreshing{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}
- (void)refresh{
    __weak BooksSearchTableViewController *weakSelf = self;
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
    BooksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:booksIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

@end
