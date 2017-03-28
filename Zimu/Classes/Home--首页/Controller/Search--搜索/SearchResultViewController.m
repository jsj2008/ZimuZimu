//
//  SearchResultViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/1.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SearchResultViewController.h"
#import "RecommendSearchTableViewController.h"
#import "ArticleSearchTableViewController.h"
#import "EvaluationSearchTableViewController.h"
#import "CourseSearchTableViewController.h"
#import "FMSearchTableViewController.h"
#import "BooksSearchTableViewController.h"

@interface SearchResultViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *titleView;                //标题栏
@property (nonatomic, strong) UIView *indicator;                //指示器
@property (nonatomic, strong) UIButton *selectButton;           //选中的按钮（标题栏中）
@property (nonatomic, strong) UIScrollView *scrollView;         //底层scrollView

@property (nonatomic, assign) NSInteger nowIndex;


@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;
    
    //添加子控制器
    [self setupChildViewController];
    
    //添加标题栏
    [self setupTitleView];
    
    //设置scrollView
    [self setupScrollView];
    
}

/**
 *  添加子控制器
 */
- (void)setupChildViewController{
    RecommendSearchTableViewController *recommendSearchVC = [[RecommendSearchTableViewController alloc]init];
    recommendSearchVC.title = @"推荐";
    recommendSearchVC.view.backgroundColor = themeGray;
    [self addChildViewController:recommendSearchVC];
    
    ArticleSearchTableViewController *articleSearch = [[ArticleSearchTableViewController alloc]init];
    articleSearch.title = @"文章";
    articleSearch.view.backgroundColor = themeGray;
    [self addChildViewController:articleSearch];
    
    EvaluationSearchTableViewController *evalutionSearchVC = [[EvaluationSearchTableViewController alloc]init];
    evalutionSearchVC.title = @"测评";
    evalutionSearchVC.view.backgroundColor = themeGray;
    [self addChildViewController:evalutionSearchVC];
    
    CourseSearchTableViewController *courseSearch = [[CourseSearchTableViewController alloc]init];
    courseSearch.title = @"课程";
    courseSearch.view.backgroundColor = themeGray;
    [self addChildViewController:courseSearch];
    
    FMSearchTableViewController *FMSearchVC = [[FMSearchTableViewController alloc]init];
    FMSearchVC.title = @"FM";
    FMSearchVC.view.backgroundColor = themeGray;
    [self addChildViewController:FMSearchVC];
    
    BooksSearchTableViewController *booksSearch = [[BooksSearchTableViewController alloc]init];
    booksSearch.title = @"书籍";
    booksSearch.view.backgroundColor = themeGray;
    [self addChildViewController:booksSearch];
}


/**
 *  设置标题栏
 */
- (void)setupTitleView{
    _titleView = [[UIView alloc]init];
    _titleView.width = kScreenWidth;
    _titleView.height = 40;
    _titleView.y = 0;
    _titleView.x = 0;
    _titleView.backgroundColor = themeWhite;
    [self.view addSubview:_titleView];
    
    //底部分割线
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, _titleView.height - 1, _titleView.width, 1);
    lineLayer.backgroundColor = themeGray.CGColor;
    [_titleView.layer addSublayer:lineLayer];
    
    //添加指示器
    _indicator = [[UIView alloc]init];
    _indicator.backgroundColor = themeYellow;
    _indicator.height = 2;
    _indicator.y = _titleView.height - _indicator.height - 2;
    
    //添加button
    NSArray *childVCs = self.childViewControllers;
    CGFloat width = (_titleView.width - 20) / childVCs.count;
    CGFloat height = _titleView.height - 15;
    for (int index = 0; index < childVCs.count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.width = width;
        button.height = height;
        button.x = width * index + 10;
        button.y = 10;
        button.tag = 10 + index;
        [_titleView addSubview:button];
        
        UIViewController *vc = self.childViewControllers[index];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:themeBlack forState:UIControlStateNormal];
        [button setTitleColor:themeYellow forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置指示器,默认选中第一个标题 推荐
        if (index == 0) {
            _nowIndex = index;
            button.enabled = NO;
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            self.selectButton = button;
            [button layoutIfNeeded];
            
            _indicator.width = _selectButton.width;
            _indicator.centerX = _selectButton.centerX;
        }
        
    }
    [_titleView addSubview:_indicator];
    
}

/*
    选择标题，指示器匹配按钮
 */
- (void)selectTitle:(UIButton *)button{
    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.selectButton.enabled = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.enabled = NO;
    self.selectButton = button;
    [button layoutIfNeeded];
    
    //移动指示器
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:0.3 options:
        UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            _indicator.width = _selectButton.width;
            _indicator.centerX = _selectButton.centerX;
        } completion:^(BOOL finished) {
            
        }];
    
    //滑动scrollView
    NSInteger index = button.tag - 10;
    _nowIndex = index;
    [_scrollView setContentOffset:CGPointMake(index * _scrollView.width, 0) animated:YES];
}

/**
 *  设置ScrollView
 */
- (void)setupScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), kScreenWidth, self.view.height - _titleView.height - 64)];
    _scrollView.backgroundColor = themeWhite;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * self.childViewControllers.count, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view insertSubview:_scrollView atIndex:0];
    //添加第一个子控制器的tableView
    [self scrollViewDidEndScrollingAnimation:_scrollView];
}

#pragma mark - UIScrollViewDelegate
//结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIButton *button = [_titleView viewWithTag:10 + index];
    [self selectTitle:button];
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
//结束滑动
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //计算出当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    NSLog(@"index : %li",index);
    //将子控制器的tableView（view）添加到scrollView中
    UITableViewController *tableVC = self.childViewControllers[index];
    tableVC.view.y = 0;
    tableVC.view.height = scrollView.height;
    tableVC.tableView.x = scrollView.contentOffset.x;
    [scrollView addSubview:tableVC.tableView];
}

- (void)reloadDataWithSearchText:(NSString *)searchText{
    NSLog(@"~~~~~~~%@~~~~~~~~",searchText);
    
    
    
}


@end
