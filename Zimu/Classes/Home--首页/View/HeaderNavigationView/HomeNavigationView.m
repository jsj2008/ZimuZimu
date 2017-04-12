//
//  HomeNavigationView.m
//  Zimu
//
//  Created by Redpower on 2017/3/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeNavigationView.h"
#import "UIImage+ZMExtension.h"
#import "TestViewController.h"
#import "SearchResultViewController.h"
#import "UIView+ViewController.h"
#import "BaseNavigationController.h"
#import "PYSearch.h"
#import "FMViewController.h"

#define homeHeaderHeight 136

@interface HomeNavigationView ()<UISearchBarDelegate, PYSearchViewControllerDelegate>

@property (nonatomic, strong) UIVisualEffectView *backGroundView;
@property (nonatomic, strong) UISearchBar *searchBar;       //搜索框
@property (nonatomic, strong) UIButton *FMButton;       //FM
@property (nonatomic, strong) UIButton *scanButton;
@property (nonatomic, strong) NSMutableArray *resultArray;

@end

@implementation HomeNavigationView

- (void)dealloc{
    [_homeTableView removeObserver:self forKeyPath:@"contentOffset" context:@"tableView"];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        
        _resultArray = [NSMutableArray array];
        [self addSubview:self.backGroundView];
        [self addSubview:self.searchBar];
        [self addSubview:self.scanButton];
        [self addSubview:self.FMButton];
        
    }
    return self;
}

//背景view
- (UIVisualEffectView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        _backGroundView.frame = self.bounds;
        _backGroundView.alpha = 0;
    }
    return _backGroundView;
}


#pragma mark - FM电台
//FM按钮
- (UIButton *)FMButton{
    _FMButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _FMButton.frame = CGRectMake(self.width - 5 - 40, (self.height - 20 - 40)/2.0 + 20, 40, 40);
    [_FMButton setImage:[UIImage imageNamed:@"home_FM"] forState:UIControlStateNormal];
    [_FMButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [_FMButton setTintColor:themeWhite];
    [_FMButton addTarget:self action:@selector(FMButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    return _FMButton;
}
- (void)FMButtonAction{
    NSLog(@"FM电台");
    FMViewController *fmVC = [[FMViewController alloc]init];
    [self.viewController.navigationController pushViewController:fmVC animated:YES];
}


#pragma mark - 扫一扫
//扫一扫按钮
- (UIButton *)scanButton{
    _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _scanButton.frame = CGRectMake(5, (self.height - 20 - 40)/2.0 + 20, 40, 40);
    [_scanButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [_scanButton setImage:[UIImage imageNamed:@"home_saoyisao"] forState:UIControlStateNormal];
    [_scanButton setTintColor:themeWhite];
    [_scanButton addTarget:self action:@selector(scanButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    return _scanButton;
}
- (void)scanButtonAction{
    NSLog(@"scan");
    
    TestViewController *testVC = [[TestViewController alloc]init];
    [self.viewController.navigationController pushViewController:testVC animated:YES];
}


#pragma mark - 搜索search
//搜索框
- (UISearchBar *)searchBar{
    CGFloat width = kScreenWidth * 250/375.0;
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake((kScreenWidth - width)/2.0, (self.height - 20 - 30)/2.0 + 20, width, 30)];
    _searchBar.placeholder = @"查找专家或问题";
    _searchBar.layer.cornerRadius = 5;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.delegate = self;
    [_searchBar setSearchFieldBackgroundImage:[UIImage imageWithColor:themeWhite size:_searchBar.bounds.size] forState:UIControlStateNormal];
    [_searchBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:_searchBar.bounds.size]];
    
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    searchField.font = [UIFont systemFontOfSize:12];
    [searchField setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    return _searchBar;
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
    [self.viewController presentViewController:navi animated:YES completion:nil];
    
}
// UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self searchButtonAction];
    return NO;
}

// - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)searchBar searchText:(NSString *)searchText{
    if (searchText.length) {
        //设置搜索建议数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSLog(@"%@",searchText);
            [_resultArray addObject:searchText];
            searchViewController.searchSuggestions = _resultArray;
            
        });
    }
}
- (void)searchViewController:(PYSearchViewController *)searchViewController shouldBeginEditing:(UISearchBar *)searchBar searchText:(NSString *)searchText{
    //设置搜索建议数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"%@",searchText);
        [_resultArray addObject:searchText];
        searchViewController.searchSuggestions = _resultArray;
        
    });
}

//选择热门搜索
- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectHotSearchAtIndex:(NSInteger)index searchText:(NSString *)searchText{
    SearchResultViewController *vc = (SearchResultViewController *)searchViewController.searchResultController;
    [vc reloadDataWithSearchText:searchText];
}
//选择搜索历史
- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectSearchHistoryAtIndex:(NSInteger)index searchText:(NSString *)searchText{
    SearchResultViewController *vc = (SearchResultViewController *)searchViewController.searchResultController;
    [vc reloadDataWithSearchText:searchText];
    
}
////选择搜索结果
//- (void)searchViewController:(PYSearchViewController *)searchViewController didSearchWithsearchBar:(UISearchBar *)searchBar searchText:(NSString *)searchText{
//    NSLog(@"搜索结果 : %@",searchText);
//    
//    SearchResultViewController *vc = (SearchResultViewController *)searchViewController.searchResultController;
//    [vc refreshData];
//}
//选择搜索建议
- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectSearchSuggestionAtIndex:(NSInteger)index searchText:(NSString *)searchText{
    SearchResultViewController *vc = (SearchResultViewController *)searchViewController.searchResultController;
    [vc reloadDataWithSearchText:searchText];
    
}



#pragma mark - observe 添加监听
- (void)setHomeTableView:(HomeTableView *)homeTableView{
    if (_homeTableView != homeTableView) {
        _homeTableView = homeTableView;
        
        //添加监听
        NSKeyValueObservingOptions option = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        [_homeTableView addObserver:self forKeyPath:@"contentOffset" options:option context:@"tableView"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    HomeTableView *tableView = (HomeTableView *)object;
    if (_homeTableView != tableView) {
        return;
    }
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    CGFloat contentOffsetY = tableView.contentOffset.y;
    
    CGFloat alphaValue = MIN(1, contentOffsetY/homeHeaderHeight);
    _backGroundView.alpha = alphaValue;
    
    if (contentOffsetY <= 0) {
        self.top = contentOffsetY;
    }
    if (contentOffsetY >= 0 && contentOffsetY <= homeHeaderHeight) {
        [_scanButton setTintColor:[UIColor changeColorWithRatio:alphaValue fromColor:@"FFFFFF" toColor:@"FEDB18"]];
        [_FMButton setTintColor:[UIColor changeColorWithRatio:alphaValue fromColor:@"FFFFFF" toColor:@"FEDB18"]];
    }
}




@end
