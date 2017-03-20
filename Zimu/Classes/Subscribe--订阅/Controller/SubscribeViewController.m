//
//  SubscribeViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribeViewController.h"
#import "SubscribeNavigationView.h"
#import "UIImage+ZMExtension.h"
#import "SubscribedExpertTableViewController.h"
#import "RecommendExpertViewController.h"

@interface SubscribeViewController ()<SubscribeNavigationViewDelegate>

@property (nonatomic, strong) SubscribeNavigationView *navigationView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.tabBarItem.title = @"订阅";
    self.view.backgroundColor = themeGray;
    
    [self setupChildViewController];
    [self setupNavigationBar];
    [self setupScrollView];
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

/**
 *  自定义导航栏
 */
- (void)setupNavigationBar{
    _navigationView = [[SubscribeNavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
}
- (void)showSubscribedExpertView{
    NSLog(@"已订");
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
}
- (void)showRecommendExpertView{
    NSLog(@"推荐");
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
}

/**
 *  添加子控制器
 */
- (void)setupChildViewController{
    SubscribedExpertTableViewController *subscribedExpertVC = [[SubscribedExpertTableViewController alloc]init];
    [self addChildViewController:subscribedExpertVC];
    
    RecommendExpertViewController *recommendExpertVC = [[RecommendExpertViewController alloc]init];
    [self addChildViewController:recommendExpertVC];
}

/**
 *  scrollView
 */
- (void)setupScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 49)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    _scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.scrollEnabled = NO;
    _scrollView.pagingEnabled = YES;
    
    
    SubscribedExpertTableViewController *subscribedExpertVC = self.childViewControllers[0];
    subscribedExpertVC.tableView.x = 0;
    subscribedExpertVC.tableView.y = 0;
    subscribedExpertVC.tableView.height = _scrollView.height;
    [_scrollView addSubview:subscribedExpertVC.tableView];
    
    RecommendExpertViewController *recommendExpertVC = self.childViewControllers[1];
    recommendExpertVC.view.x = kScreenWidth;
    recommendExpertVC.view.y = 0;
    recommendExpertVC.view.height = _scrollView.height;
    [_scrollView addSubview:recommendExpertVC.view];
    
    [self.view addSubview:_scrollView];
}



@end
