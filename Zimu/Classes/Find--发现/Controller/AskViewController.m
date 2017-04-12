//
//  AskViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AskViewController.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "YXSliderBar.h"
#import "AskQuestionTableViewController.h"

@interface AskViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) YXSliderBar *sliderBar;       //滑动标题栏
@property (nonatomic, strong) UIScrollView *contentScrollView;  //内容scrollView

@property (nonatomic, strong) NSArray *titleArray;      //类目数组,从接口获取

@end

@implementation AskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeGray;
    self.title = @"问答";
    
    UIBarButtonItem *rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"home_search" title:@"" target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    _titleArray = @[@"亲子",@"第三者",@"婚姻",@"家庭创伤",@"情绪",@"相处技巧",@"养老",@"冷战",@"安全感"];
    
    //添加子控制器
    [self setupChildViewControllers];
    //添加标题栏
    [self setupSliderBar];
    //添加contentScrollView
    [self setupContentScrollView];
    
}

//搜索
- (void)search{
    NSLog(@"搜索");
}

//添加子控制器
- (void)setupChildViewControllers{
    for (NSString *title in _titleArray) {
        AskQuestionTableViewController *vc = [[AskQuestionTableViewController alloc]init];
        vc.view.backgroundColor = [UIColor clearColor];
        vc.title = title;
        [self addChildViewController:vc];
    }
}


/**
 *  滑动标题栏sliderBar
 */
- (void)setupSliderBar{
    _sliderBar = [[YXSliderBar alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    _sliderBar.backgroundColor = themeWhite;
    _sliderBar.itemsTitle = _titleArray;
    _sliderBar.itemSelectedColor = themeYellow;
    _sliderBar.itemColor = [UIColor colorWithHexString:@"000000"];
    _sliderBar.sliderColor = themeYellow;
    
    //画条分割线
    CALayer *line = [[CALayer alloc]init];
    line.frame = CGRectMake(0, _sliderBar.height - 1, _sliderBar.width, 1);
    line.backgroundColor = themeGray.CGColor;
    [_sliderBar.layer addSublayer:line];
    
    [_sliderBar slideBarItemSelectedCallback:^(NSUInteger index) {
        NSLog(@"index : %li", index);
        [_contentScrollView setContentOffset:CGPointMake(kScreenWidth * index, 0) animated:YES];
    }];
    [self.view addSubview:_sliderBar];
}

/**
 *  contentScrollView
 */
- (void)setupContentScrollView{
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_sliderBar.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(_sliderBar.frame))];
    _contentScrollView.contentSize = CGSizeMake(kScreenWidth * _titleArray.count, 0);
    _contentScrollView.backgroundColor = [UIColor clearColor];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self scrollViewDidEndScrollingAnimation:_contentScrollView];
    
    [self.view addSubview:_contentScrollView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    [_sliderBar selectSlideBarItemAtIndex:index];
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    UITableViewController *vc = self.childViewControllers[index];
    vc.tableView.x = kScreenWidth * index;
    vc.tableView.y = 0;
    vc.tableView.height = _contentScrollView.height;
    
    [_contentScrollView addSubview:vc.tableView];
    
}





@end
