//
//  TestViewController.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "TestViewController.h"
#import "HomeArrayDataSource.h"
#import "HomeTableView.h"

static NSString *identifier = @"homeCell";
@interface TestViewController ()

@property (nonatomic, strong) HomeTableView *tableView;
@property (nonatomic, strong) HomeArrayDataSource *homeArrayDataSource;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = themeWhite;
    self.title = @"测试页";
    
    [self setupTableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//创建tableView
- (void)setupTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.homeArrayDataSource = [[HomeArrayDataSource alloc]initWithDataArray:@[@"吕布",@"赵云",@"典韦",@"关羽",@"马超",@"张飞",@"吕布",@"赵云",@"典韦",@"关羽",@"马超",@"张飞"] cellIdentifier:identifier homeTableViewCellBlock:^(UITableViewCell *cell, NSString *text) {
        cell.textLabel.text = text;
    }];
    self.tableView = [[HomeTableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain homeArrayDataSource:self.homeArrayDataSource];
    [self.view addSubview:self.tableView];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 300)];
    headerView.backgroundColor = [UIColor cyanColor];
    self.tableView.tableHeaderView = headerView;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(300, 0, 0, 0);
}






@end
