//
//  MySecretViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MySecretViewController.h"
#import "MySecretTableView.h"

@interface MySecretViewController ()

@property (nonatomic, strong) MySecretTableView *tableView;
@end

@implementation MySecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的心事";
    [self makeTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeTableView{
    if (!_tableView) {
        _tableView = [[MySecretTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
    }
}
@end
