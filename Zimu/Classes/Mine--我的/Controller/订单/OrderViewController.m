//
//  OrderViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "OrderViewController.h"
#import "AllOrderTableViewController.h"
#import "CompleteOrderTableViewController.h"
#import "NotPayOrderTableViewController.h"

@interface OrderViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    self.view.backgroundColor = themeWhite;
    
    [self setupChildViewController];
    [self setupNavigationView];
    [self setupScrollView];
}

/**
 *  添加子控制器
 */
- (void)setupChildViewController{
    AllOrderTableViewController *allOrderVC = [[AllOrderTableViewController alloc]init];
    allOrderVC.title = @"全部";
    [self addChildViewController:allOrderVC];
    
    CompleteOrderTableViewController *completeOrderVC = [[CompleteOrderTableViewController alloc]init];
    completeOrderVC.title = @"交易完成";
    [self addChildViewController:completeOrderVC];
    
    NotPayOrderTableViewController *notPayOrderVC = [[NotPayOrderTableViewController alloc]init];
    notPayOrderVC.title = @"待付款";
    [self addChildViewController:notPayOrderVC];
}


/**
 *  自定义导航栏
 */
- (void)setupNavigationView{
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    _navigationView.backgroundColor = themeWhite;
    [self.view addSubview:_navigationView];
    CALayer *line = [[CALayer alloc]init];
    line.frame = CGRectMake(0, _navigationView.height - 1, _navigationView.width, 1);
    line.backgroundColor = themeGray.CGColor;
    [_navigationView.layer addSublayer:line];

    //指示器
    _indicatorView = [[UIView alloc]init];
    _indicatorView.backgroundColor = themeYellow;
    _indicatorView.height = 2;
    _indicatorView.y = _navigationView.height - _indicatorView.height;
    [_navigationView addSubview:_indicatorView];
    
    //添加button
    NSArray *childVCs = self.childViewControllers;
    CGFloat width = kScreenWidth/3.0;
    CGFloat height = 25;
    CGFloat y = ((_navigationView.height - 11) - height)/2.0 + 5;
    for (int index = 0; index < childVCs.count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        CGFloat x = index ? CGRectGetWidth(_navigationView.frame)/3.0 : CGRectGetWidth(_navigationView.frame)/3.0 - width;
        button.frame = CGRectMake(index * (width), y, width, height);
        button.tag = 140 + index;
        [_navigationView addSubview:button];
        
        UIViewController *vc = self.childViewControllers[index];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:themeBlack forState:UIControlStateNormal];
        [button setTitleColor:themeYellow forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置指示器,默认选中第一个标题 推荐
        if (index == 0) {
            button.enabled = NO;
            self.selectButton = button;
            [button layoutIfNeeded];
            
            _indicatorView.width = _selectButton.titleLabel.width;
            _indicatorView.centerX = _selectButton.centerX;
        }
        
    }
    [_navigationView addSubview:_indicatorView];
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
    NSInteger index = button.tag - 140;
    [_scrollView setContentOffset:CGPointMake(index * _scrollView.width, 0) animated:YES];
}



/**
 *  scrollView
 */
- (void)setupScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_navigationView.frame), kScreenWidth, kScreenHeight - 40 - 64)];
    _scrollView.backgroundColor = themeGray;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    _scrollView.contentOffset = CGPointMake(0, 0);       //默认选择推荐页
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
    UIButton *button = [_navigationView viewWithTag:140 + index];
    [self selectTitle:button];
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //计算出当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UITableViewController *tableVC = self.childViewControllers[index];
    tableVC.view.x = _scrollView.width * index;
    tableVC.view.y = 0;
    tableVC.view.height = _scrollView.height;
    [_scrollView addSubview:tableVC.view];
}


@end
