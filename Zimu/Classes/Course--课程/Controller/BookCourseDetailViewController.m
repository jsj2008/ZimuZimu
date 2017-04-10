//
//  BookCourseDetailViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BookCourseDetailViewController.h"
#import "BookCourseCommentTableViewController.h"
#import "BookCourseListTableViewController.h"
#import "UIImage+ZMExtension.h"
#import "UIView+SnailUse.h"
#import "SnailQuickMaskPopups.h"
#import "PaymentChannelView.h"

@interface BookCourseDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *indicator;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) SnailQuickMaskPopups *popup;

@end

@implementation BookCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"书籍名称";
    self.view.backgroundColor = themeGray;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    
    [self addChildVC];
    [self setupTitleView];
    [self setupScrollView];
    [self setupBottomView];
}

- (void)addChildVC{
    BookCourseCommentTableViewController *commentVC = [[BookCourseCommentTableViewController alloc]init];
    commentVC.title = @"详情评论";
    commentVC.view.backgroundColor = [UIColor clearColor];
    [self addChildViewController:commentVC];
    
    BookCourseListTableViewController *listVC = [[BookCourseListTableViewController alloc]init];
    listVC.title = @"章节列表";
    listVC.view.backgroundColor = [UIColor clearColor];
    [self addChildViewController:listVC];
}


/**
 *  创建titleView
 */
- (void)setupTitleView{
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    _titleView.backgroundColor = themeWhite;
    [self.view addSubview:_titleView];
    CALayer *topLine = [[CALayer alloc]init];
    topLine.frame = CGRectMake(0, 0, _titleView.width, 1.0f);
    topLine.backgroundColor = themeGray.CGColor;
    [_titleView.layer addSublayer:topLine];
    CALayer *botLine = [[CALayer alloc]init];
    botLine.frame = CGRectMake(0, _titleView.height - 1.0f, _titleView.width, 1.0f);
    botLine.backgroundColor = themeGray.CGColor;
    [_titleView.layer addSublayer:botLine];
    
    //指示器
    _indicator = [[UIView alloc]init];
    _indicator.backgroundColor = themeYellow;
    _indicator.height = 2;
    _indicator.y = _titleView.height - _indicator.height;
    
    //创建button
    NSArray *VCs = self.childViewControllers;
    CGFloat width = (kScreenWidth - 100)/2.0;
    CGFloat height = 25;
    CGFloat y = (_titleView.height - height)/2.0;
    for (int index = 0; index < VCs.count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(50 + index * width, y, width, height);
        button.tag = 50 + index;
        [_titleView addSubview:button];
        
        UIViewController *vc = VCs[index];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"222222"] forState:UIControlStateNormal];
        [button setTitleColor:themeYellow forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        
        if (index == 0) {
            button.enabled = NO;
            _selectButton = button;
            [button layoutIfNeeded];
            
            _indicator.width = button.titleLabel.width;
            _indicator.centerX = button.centerX;
        }
    }
    [_titleView addSubview:_indicator];
    
}

- (void)selectButton:(UIButton *)button{
    _selectButton.enabled = YES;
    button.enabled = NO;
    _selectButton = button;
    
    [UIView animateWithDuration:0.5 animations:^{
        _indicator.centerX = _selectButton.centerX;
    }];
    
    NSInteger index = button.tag - 50;
    [_scrollView setContentOffset:CGPointMake(kScreenWidth * index, 0) animated:YES];
    
}

/**
 *  创建scrollView
 */
- (void)setupScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(_titleView.frame) - 49 - 64)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth * self.childViewControllers.count, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = themeGray;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self scrollViewDidEndScrollingAnimation:_scrollView];
    [self.view addSubview:_scrollView];
    
}

//UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //计算出当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //将子控制器的tableView（view）添加到scrollView中
    if (index == 0) {
        BookCourseCommentTableViewController *commentVC = self.childViewControllers[index];
        commentVC.tableView.x = _scrollView.width * index;
        commentVC.tableView.y = 0;
        commentVC.tableView.height = _scrollView.height;
        [_scrollView addSubview:commentVC.tableView];
    }else{
        BookCourseListTableViewController *listVC = self.childViewControllers[index];
        listVC.view.x = _scrollView.width * index;
        listVC.view.y = 0;
        listVC.view.height = _scrollView.height;
        [_scrollView addSubview:listVC.view];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    UIButton *button = [_titleView viewWithTag:50 + index];
    [self selectButton:button];
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - 底部view
- (void)setupBottomView{
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 49 - 64, kScreenWidth, 49)];
    _bottomView.backgroundColor = themeWhite;
    [self.view addSubview:_bottomView];
    CALayer *topLine = [[CALayer alloc]init];
    topLine.frame = CGRectMake(0, 0, _bottomView.width, 1.0f);
    topLine.backgroundColor = themeGray.CGColor;
    [_bottomView.layer addSublayer:topLine];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    buyButton.frame = CGRectMake(10, 4.5, 260/375.0 * kScreenWidth, 40);
    [buyButton setBackgroundColor:themeYellow];
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyButton setTitleColor:themeWhite forState:UIControlStateNormal];
    buyButton.titleLabel.font = [UIFont systemFontOfSize:15];
    buyButton.layer.cornerRadius = 5;
    buyButton.layer.masksToBounds = YES;
    [buyButton addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:buyButton];
    
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = _bottomView.width - CGRectGetMaxX(buyButton.frame) - 10 - 10;
    collectButton.frame = CGRectMake(CGRectGetMaxX(buyButton.frame) + 10, (_bottomView.height - 20)/2.0, width, 20);
    [collectButton setBackgroundColor:[UIColor clearColor]];
    [collectButton setTitle:@" 收藏" forState:UIControlStateNormal];
    [collectButton setTitle:@" 已收藏" forState:UIControlStateSelected];
    [collectButton setTitleColor:[UIColor colorWithHexString:@"6F6F6F"] forState:UIControlStateNormal];
    collectButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [collectButton setImage:[UIImage imageNamed:@"book_shoucang"] forState:UIControlStateNormal];
    [collectButton setImage:[UIImage imageNamed:@"book_shoucang_click"] forState:UIControlStateSelected];
    [collectButton addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:collectButton];
}

//立即购买
- (void)buy{
    NSLog(@"立即购买");
    PaymentChannelView *view = [UIView paymentChannelView];
    _popup = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:view];
    _popup.isAllowPopupsDrag = YES;
    _popup.dampingRatio = 0.9;
    _popup.presentationStyle = PresentationStyleBottom;
    [_popup presentAnimated:YES completion:nil];
}

//收藏
- (void)collection:(UIButton *)button{
    button.selected = !button.selected;
    NSLog(@"收藏");
}



@end
