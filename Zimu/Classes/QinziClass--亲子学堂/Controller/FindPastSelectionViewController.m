//
//  FindPastSelectionViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindPastSelectionViewController.h"
#import "UIImage+ZMExtension.h"
#import "FindDailyTableView.h"

@interface FindPastSelectionViewController ()

@property (nonatomic, strong) FindDailyTableView *findDailyTableView;

@end

@implementation FindPastSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;
    self.title = @"每日精选";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"F1C40F"] size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupFindTableView];
}

/**
 *  FindTableView
 */
- (void)setupFindTableView{
    _findDailyTableView = [[FindDailyTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_findDailyTableView];
}

@end
