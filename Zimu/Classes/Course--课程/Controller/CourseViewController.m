//
//  CourseViewController.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CourseViewController.h"
#import "HomeVideoViewController.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "SDCycleScrollView.h"
#import "CourseTabelView.h"
#import "PYSearch.h"
#import "SearchResultViewController.h"
#import "UIImage+ZMExtension.h"

#define TITLE_HEIGHT 45
@interface CourseViewController ()<UISearchBarDelegate, PYSearchViewControllerDelegate>
//列表
@property (nonatomic, strong) CourseTabelView *courseTableView;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeNavRightBtn];
    [self setUpTableView];
    [self setUpSearchBar];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [_courseTableView viewWillDisappear];
}
- (void)viewWillAppear:(BOOL)animated{
    if (_courseTableView) {
        [_courseTableView reloadData];
    }
}
- (void)setUpSearchBar{
    UIBarButtonItem *searchBtn = [UIBarButtonItem barButtonItemWithImageName:@"course_searchicon" title:@"" target:self action:@selector(search)];
    self.navigationItem.leftBarButtonItem = searchBtn;
}

- (void)setUpTableView{
    if (!_courseTableView) {
        _courseTableView = [[CourseTabelView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + 20) style:UITableViewStylePlain];
        [self.view addSubview:_courseTableView];
    }
}

- (void)makeNavRightBtn{
    UIBarButtonItem *searchBtn = [UIBarButtonItem barButtonItemWithImageName:@"course_nav_right" title:@"" target:self action:@selector(fm)];
    self.navigationItem.rightBarButtonItem = searchBtn;
}
#pragma mark - 按钮点击
- (void)search{
    [self searchButtonAction];
}
- (void)fm{
    NSLog(@"fm点击");
}

- (void)searchButtonAction{
    NSArray *hotArray = @[@"沙克斯军",@"都是大幅度",@"ds ",@"手动",@"多岁的",@"额外若翁如",@"让我"];
    PYSearchViewController *searchVC = [PYSearchViewController searchViewControllerWithHotSearches:hotArray searchBarPlaceholder:@"请输入搜索内容"];
    //搜索代理方法
    searchVC.delegate = self;
    //搜索结果展示样式
    searchVC.searchResultShowMode = PYSearchResultShowModeEmbed;
    //设置搜索结果视图控制器
    searchVC.searchResultController = [[SearchResultViewController alloc]init];
    searchVC.didSearchBlock = ^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *text){
        SearchResultViewController *vc = (SearchResultViewController *)searchViewController.searchResultController;
        [vc reloadDataWithSearchText:text];
    };
    
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:searchVC];
    navi.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navi animated:YES completion:nil];
    
}

@end
