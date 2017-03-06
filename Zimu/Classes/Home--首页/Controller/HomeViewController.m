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
#import "TestViewController.h"
#import "UMMobClick/MobClick.h"

#import "HomeArrayDataSource.h"
#import "HomeTableView.h"
#import "MJRefresh.h"

#import "HeaderNavigationView.h"
#import "HomeHeaderView.h"

#define kHeaderViewHeight 380

@interface HomeViewController ()

@property (nonatomic, strong) HeaderNavigationView *headerNaviView;     //导航栏
@property (nonatomic, strong) HomeHeaderView *headView;     //做为tableView的headerView

@property (nonatomic, strong) HomeTableView *tableView;
@property (nonatomic, strong) HomeArrayDataSource *homeArrayDataSource;     //tableView数据源方法

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;
    
    //设置系统导航栏为透明
    self.title = @"";
    self.tabBarItem.title = @"首页";
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    [self setupTableView];
    
    [self setupHeaderView];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}

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
    
    
//    CGFloat contentOffsetY = homeTableview.contentOffset.y;
//    NSLog(@"offsetY : %lf",contentOffsetY);
    
}

/**
 *  创建tableView
 */
- (void)setupTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;     //为YES，tableView会往下偏移64
    self.homeArrayDataSource = [[HomeArrayDataSource alloc]initWithDataArray:@[@"cycle_01.jpg",@"cycle_02.jpg",@"cycle_03.jpg",@"cycle_04.jpg",@"cycle_05.jpg",@"cycle_06.jpg",@"cycle_07.jpg"] cellIdentifier:@"homeTableViewCell" homeTableViewCellBlock:^(HomeTableViewCell *cell, NSString *text) {
        cell.imageString = text;
    }];
    self.tableView = [[HomeTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain homeArrayDataSource:self.homeArrayDataSource];
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
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40 + 49)];
    [button setTitle:@"点击查看更多" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 10 + 49, 0)];
    [button setBackgroundColor:themeGray];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    self.tableView.tableFooterView = button;
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击查看更多");
    }];
    
}


//刷新
- (void)refresh{
    [NSTimer scheduledTimerWithTimeInterval:3.5f repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self.tableView.mj_header endRefreshing];
    }];
}


@end
