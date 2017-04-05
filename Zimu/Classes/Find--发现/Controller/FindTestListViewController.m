//
//  FindTestListViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindTestListViewController.h"
#import "FindTestListTableView.h"

@interface FindTestListViewController ()

@property (nonatomic, strong) FindTestListTableView *tableView;

@end

@implementation FindTestListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTable];
    self.title = @"测试";
    self.view.backgroundColor = themeWhite;
}

- (void)setTable{
    if (!_tableView) {
        _tableView = [[FindTestListTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = themeGray;
        [self.view addSubview:_tableView];
    }
}

@end
