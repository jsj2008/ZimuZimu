//
//  HomeViewController.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIBarButtonItem+ZMExtension.h"
#import "UMMobClick/MobClick.h"
#import "MJRefresh.h"
#import "UIImage+ZMExtension.h"

#import "TestViewController.h"

#import "HeaderNavigationView.h"
#import "HomeTableView.h"
#import "HomeHeaderView.h"

#define kHeaderViewHeight 195           //即轮播图高度

@interface HomeViewController ()

@property (nonatomic, strong) HeaderNavigationView *headerNaviView;     //导航栏
@property (nonatomic, strong) HomeHeaderView *headView;     //做为tableView的headerView

@property (nonatomic, strong) HomeTableView *tableView;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;
    
    //设置系统导航栏为透明
    self.title = @"";
    self.tabBarItem.title = @"首页";
    
    [self setupTableView];
    
    [self setupHeaderView];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 0)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 0)] forBarMetrics:UIBarMetricsDefault];

}

#pragma mark - observe
- (void)dealloc{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset" context:@"homeTableView"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    HomeTableView *homeTableview = (HomeTableView *)object;
    if (self.tableView != homeTableview) {
        return;
    }
    
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }

}

/**
 *  创建tableView
 */
- (void)setupTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;     //为YES，tableView会往下偏移64
    self.tableView = [[HomeTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
    
    //添加KVO监控
    NSKeyValueObservingOptions option = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:option context:@"homeTableView"];
    
    //刷新控件
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    mj_header.mj_y = 300;
    self.tableView.mj_header = mj_header;

    //导航栏  (要在tableView创建之后)
    self.headerNaviView = [[HeaderNavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    self.headerNaviView.homeTableView = self.tableView;
    [self.view addSubview:self.headerNaviView];
}

/**
 *  创建headerView,作为tableView的headerView
 */
- (void)setupHeaderView{
    self.headView = [[HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, kHeaderViewHeight)];
    self.tableView.tableHeaderView = self.headView;
    
    //设置footerView
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 49)];
    footerView.backgroundColor = themeGray;
    self.tableView.tableFooterView = footerView;
    
}


//下拉刷新
- (void)refresh{
    [NSTimer scheduledTimerWithTimeInterval:3.5f repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self.tableView.mj_header endRefreshing];
    }];
}


@end
