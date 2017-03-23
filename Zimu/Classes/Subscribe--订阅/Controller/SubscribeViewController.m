//
//  SubscribeViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribeViewController.h"
//#import "SubscribeNavigationView.h"
#import "UIImage+ZMExtension.h"
#import "SubscribedExpertTableViewController.h"
#import "RecommendExpertViewController.h"

@interface SubscribeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIVisualEffectView *navigationView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.tabBarItem.title = @"订阅";
    self.view.backgroundColor = themeGray;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    [self setupChildViewController];
    [self setupNavigationView];
    [self setupScrollView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 0)];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 0)] forBarMetrics:UIBarMetricsDefault];
    
}


/**
 *  添加子控制器
 */
- (void)setupChildViewController{
    SubscribedExpertTableViewController *subscribedExpertVC = [[SubscribedExpertTableViewController alloc]init];
    subscribedExpertVC.title = @"订阅";
    [self addChildViewController:subscribedExpertVC];
    
    RecommendExpertViewController *recommendExpertVC = [[RecommendExpertViewController alloc]init];
    recommendExpertVC.title = @"推荐";
    [self addChildViewController:recommendExpertVC];
}


/**
 *  自定义导航栏
 */
- (void)setupNavigationView{
    _navigationView = [[UIVisualEffectView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _navigationView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    [self.view addSubview:_navigationView];
    //搜索按钮
    [_navigationView addSubview:self.searchButton];
    
    //指示器
    _indicatorView = [[UIView alloc]init];
    _indicatorView.backgroundColor = themeYellow;
    _indicatorView.height = 2;
    _indicatorView.y = _navigationView.height - _indicatorView.height;
    [_navigationView addSubview:_indicatorView];
    
    //添加button
    NSArray *childVCs = self.childViewControllers;
    CGFloat width = 60;
    CGFloat height = 25;
    CGFloat y = ((_navigationView.height - 20) - height)/2.0 + 20;
    for (int index = 0; index < childVCs.count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat x = index ? CGRectGetWidth(_navigationView.frame)/2.0 : CGRectGetWidth(_navigationView.frame)/2.0 - width;
        button.frame = CGRectMake(x, y, width, height);
        button.tag = 20 + index;
        [_navigationView addSubview:button];
        
        UIViewController *vc = self.childViewControllers[index];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:themeBlack forState:UIControlStateNormal];
        [button setTitleColor:themeYellow forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置指示器,默认选中第一个标题 推荐
        if (index == 1) {
            button.enabled = NO;
            self.selectButton = button;
            [button layoutIfNeeded];
            
            _indicatorView.width = _selectButton.titleLabel.width;
            _indicatorView.centerX = _selectButton.centerX;
        }
        
    }
    [_navigationView addSubview:_indicatorView];
}
//搜索按钮
- (UIButton *)searchButton{
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setImage:[UIImage imageNamed:@"course_search"] forState:UIControlStateNormal];
    _searchButton.frame = CGRectMake(15, (_navigationView.height - 20 - 30)/2.0 + 20, 30, 30);
    [_searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    return _searchButton;
}
- (void)searchButtonAction{
    NSLog(@"搜索");
}
//选择标题，指示器匹配按钮
- (void)selectTitle:(UIButton *)button{
    self.selectButton.enabled = YES;
    button.enabled = NO;
    self.selectButton = button;
    [button layoutIfNeeded];
    
    //移动指示器
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:0.3 options:
     UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
         _indicatorView.width = _selectButton.titleLabel.width;
         _indicatorView.centerX = _selectButton.centerX;
     } completion:^(BOOL finished) {
         
     }];
    
    //滑动scrollView
    NSInteger index = button.tag - 20;
    [_scrollView setContentOffset:CGPointMake(index * _scrollView.width, 0) animated:YES];
}



/**
 *  scrollView
 */
- (void)setupScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 49)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    _scrollView.contentOffset = CGPointMake(kScreenWidth, 0);       //默认选择推荐页
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self scrollViewDidEndScrollingAnimation:_scrollView];
    [self.view addSubview:_scrollView];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    UIButton *button = [_navigationView viewWithTag:20 + index];
    [self selectTitle:button];
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //计算出当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
//    NSLog(@"index : %li",index);
    //将子控制器的tableView（view）添加到scrollView中
    if (index == 0) {
        SubscribedExpertTableViewController *subscribedExpertVC = self.childViewControllers[index];
        subscribedExpertVC.tableView.x = _scrollView.width * index;
        subscribedExpertVC.tableView.y = 0;
        subscribedExpertVC.tableView.height = _scrollView.height;
        [_scrollView addSubview:subscribedExpertVC.tableView];
    }else{
        RecommendExpertViewController *recommendExpertVC = self.childViewControllers[index];
        recommendExpertVC.view.x = _scrollView.width * index;
        recommendExpertVC.view.y = 0;
        recommendExpertVC.view.height = _scrollView.height;
        [_scrollView addSubview:recommendExpertVC.view];
    }
}



@end
