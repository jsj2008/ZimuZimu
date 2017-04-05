//
//  FMViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMViewController.h"
#import "FMPlayView.h"
#import "FMTableView.h"

@interface FMViewController ()

@property (nonatomic, strong) FMPlayView *FMPlayView;
@property (nonatomic, strong) FMTableView *tableView;

@end

@implementation FMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"心灵FM";
    self.view.backgroundColor = themeGray;
    
    [self.view addSubview:self.tableView];
    
}

/**
 *  创建FMTableView
 */
- (FMTableView *)tableView{
    if (!_tableView) {
        _tableView = [[FMTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.tableHeaderView = self.FMPlayView;
    }
    return _tableView;
}

- (FMPlayView *)FMPlayView{
    if (!_FMPlayView) {
        _FMPlayView = [[FMPlayView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenWidth)];
        _FMPlayView.backgroundColor = themeWhite;
    }
    return _FMPlayView;
}


@end
