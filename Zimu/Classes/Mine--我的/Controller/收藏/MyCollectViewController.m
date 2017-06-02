//
//  MyCollectViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MyCollectViewController.h"
#import "UIImage+ZMExtension.h"
#import "BrowsVideoViewController.h"
#import "BrowsArticleViewController.h"
#import "BrowsFMViewController.h"

@interface MyCollectViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIVisualEffectView *navigationView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIView *indicatorView;
@end


@implementation MyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.view.backgroundColor = themeWhite;
    
    [self setupChildViewController];
    [self setupNavigationView];
    [self setupScrollView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
/**
 *  添加子控制器
 */
- (void)setupChildViewController{
    BrowsVideoViewController *videoVC = [[BrowsVideoViewController alloc]init];
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
    
    BrowsArticleViewController *articleVC = [[BrowsArticleViewController alloc]init];
    articleVC.title = @"文章";
    [self addChildViewController:articleVC];
    
    BrowsFMViewController *fmVC = [[BrowsFMViewController alloc]init];
    fmVC.title = @"FM";
    [self addChildViewController:fmVC];
}


/**
 *  自定义导航栏
 */
- (void)setupNavigationView{
    _navigationView = [[UIVisualEffectView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    //    _navigationView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyle];
    _navigationView.backgroundColor = themeWhite;
    [self.view addSubview:_navigationView];
    //搜索按钮
    //    [_navigationView addSubview:self.searchButton];
    
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
        button.frame = CGRectMake(index * width, y, width, height);
        button.tag = 20 + index;
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
////搜索按钮
//- (UIButton *)searchButton{
//    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_searchButton setImage:[UIImage imageNamed:@"course_search"] forState:UIControlStateNormal];
//    _searchButton.frame = CGRectMake(15, (_navigationView.height - 20 - 30)/2.0 + 20, 30, 30);
//    [_searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
//
//    return _searchButton;
//}
//- (void)searchButtonAction{
//    NSLog(@"搜索");
//}
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
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 36, kScreenWidth, kScreenHeight - 36)];
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
        BrowsVideoViewController *videoVC = self.childViewControllers[index];
        videoVC.view.x = _scrollView.width * index;
        videoVC.view.y = 0;
        videoVC.view.height = _scrollView.height;
        [_scrollView addSubview:videoVC.view];
    }else if (index == 1){
        BrowsArticleViewController *articleVC = self.childViewControllers[index];
        articleVC.view.x = _scrollView.width * index;
        articleVC.view.y = 0;
        articleVC.view.height = _scrollView.height;
        [_scrollView addSubview:articleVC.view];
    }
    else{
        BrowsFMViewController *FMVC = self.childViewControllers[index];
        FMVC.view.x = _scrollView.width * index;
        FMVC.view.y = 0;
        FMVC.view.height = _scrollView.height;
        [_scrollView addSubview:FMVC.view];
    }
}

@end
