//
//  HeaderNavigationView.m
//  Zimu
//
//  Created by Redpower on 2017/2/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HeaderNavigationView.h"
#import "ListSelectButton.h"
#import "UIImage+ZMExtension.h"
#import "TestViewController.h"
#import "UIView+ViewController.h"
#import "BaseNavigationController.h"
#import "YMCitySelect.h"
#import "PYSearch.h"

#define homeHeaderHeight 136

@interface HeaderNavigationView ()<UISearchBarDelegate, YMCitySelectDelegate, PYSearchViewControllerDelegate>

@property (nonatomic, strong) UIVisualEffectView *backGroundView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) ListSelectButton *addressButton;
@property (nonatomic, strong) UIButton *scanButton;

@end

@implementation HeaderNavigationView

- (void)dealloc{
    [_homeTableView removeObserver:self forKeyPath:@"contentOffset" context:@"tableView"];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        
        [self addSubview:self.backGroundView];
        [self addSubview:self.searchBar];
        [self addSubview:self.searchButton];
        [self addSubview:self.addressButton];
        [self addSubview:self.scanButton];
        
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

//搜索框
- (UISearchBar *)searchBar{
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(-self.bounds.size.width + 90, (self.bounds.size.height - 20 - 30)/2.0 + 20, self.bounds.size.width - 105, 30)];
    _searchBar.placeholder = @"请输入咨询问题或专家名字";
    _searchBar.layer.cornerRadius = 15;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.delegate = self;
    [_searchBar setSearchFieldBackgroundImage:[UIImage imageWithColor:themeWhite size:_searchBar.bounds.size] forState:UIControlStateNormal];
    [_searchBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:_searchBar.bounds.size]];
    
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    searchField.font = [UIFont systemFontOfSize:12];
    [searchField setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    return _searchBar;
}

//搜索按钮
- (UIButton *)searchButton{
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setImage:[UIImage imageNamed:@"home_search_icon"] forState:UIControlStateNormal];
    _searchButton.frame = CGRectMake(15, (self.bounds.size.height - 20 - 30)/2.0 + 20, 30, 30);
    [_searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    return _searchButton;
    
    
}

//地址按钮
- (ListSelectButton *)addressButton{
    _addressButton = [[ListSelectButton alloc]initWithFrame:CGRectMake(10, (self.bounds.size.height - 20 - 30)/2.0 + 20, 70, 30) title:@"地址" imageName:@"icon_arrow" target:self action:@selector(selectAddress)];
    
    _addressButton.backgroundColor = [UIColor clearColor];
    _addressButton.ZMImageSite = ZMImageSiteRight;
    
    _addressButton.hidden = YES;
    return _addressButton;
}

//扫一扫按钮
- (UIButton *)scanButton{
    _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _scanButton.frame = CGRectMake(self.bounds.size.width - 30 - 15, (self.bounds.size.height - 20 - 30)/2.0 + 20, 30, 30);
    [_scanButton setImage:[UIImage imageNamed:@"home_email_black"] forState:UIControlStateNormal];
    
    [_scanButton addTarget:self action:@selector(scanButtonAction) forControlEvents:UIControlEventTouchUpInside];

    return _scanButton;
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
    
    if (contentOffsetY < 0) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
        if (contentOffsetY < homeHeaderHeight) {
            //
            [UIView animateWithDuration:0.25 animations:^{
                _searchBar.frame = CGRectMake(-self.bounds.size.width + 90, (self.bounds.size.height - 20 - 30)/2.0 + 20, self.bounds.size.width - 105, 30);
                _searchButton.alpha = 1;
                _scanButton.alpha = 1;
                
            } completion:^(BOOL finished) {
                _addressButton.hidden = YES;
            }];
        }else if (contentOffsetY >= homeHeaderHeight){
            //
            [UIView animateWithDuration:0.25 animations:^{
                _searchBar.frame = CGRectMake(90, (self.bounds.size.height - 20 - 30)/2.0 + 20, self.bounds.size.width - 105, 30);
                _searchButton.alpha = 1 - alphaValue;
                _scanButton.alpha  =1 - alphaValue;
            }completion:^(BOOL finished) {
                _addressButton.hidden = NO;
            }];
        }
    }
}

#pragma mark - 搜索search
- (void)searchButtonAction{
    NSArray *hotArray = @[@"沙克斯军",@"都是大幅度",@"ds ",@"手动",@"多岁的",@"额外若翁如",@"让我"];
    PYSearchViewController *searchVC = [PYSearchViewController searchViewControllerWithHotSearches:hotArray searchBarPlaceholder:@"请输入搜索内容"];
    //搜索代理方法
    searchVC.delegate = self;
    //搜索结果展示样式
    searchVC.searchResultShowMode = PYSearchResultShowModeEmbed;
    //设置搜索结果视图控制器
    searchVC.searchResultController = [[TestViewController alloc]init];

    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:searchVC];
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
            
            searchViewController.searchSuggestions = @[@"sdsd",@"fdf",@"dsds",@"ewr",@"vfvd",@"rwrwe",@"dsffshskhhs",@"ewr",@"vfvd",@"rwrwe",@"dsffshskhhs",@"ewr",@"vfvd",@"rwrwe",@"dsffshskhhs",@"ewr",@"vfvd",@"rwrwe",@"dsffshskhhs"];
            
        });
    }
}
//选择热门搜索
- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectHotSearchAtIndex:(NSInteger)index searchText:(NSString *)searchText{
    NSLog(@"热门搜索 : %@",searchText);
}
//选择搜索历史
- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectSearchHistoryAtIndex:(NSInteger)index searchText:(NSString *)searchText{
    NSLog(@"搜索历史 : %@",searchText);
    
}
//选择搜索结果
- (void)searchViewController:(PYSearchViewController *)searchViewController didSearchWithsearchBar:(UISearchBar *)searchBar searchText:(NSString *)searchText{
    NSLog(@"搜索结果 : %@",searchText);
    
}
//选择搜索建议
- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectSearchSuggestionAtIndex:(NSInteger)index searchText:(NSString *)searchText{
    NSLog(@"搜索建议 : %@",searchText);
    
}



#pragma mark - 扫一扫
- (void)scanButtonAction{
    NSLog(@"scan");
    
    TestViewController *testVC = [[TestViewController alloc]init];
    [self.viewController.navigationController pushViewController:testVC animated:YES];
}

#pragma mark - 切换地址
- (void)selectAddress{
    YMCitySelect *YMCitySelectVC = [[YMCitySelect alloc]init];
    YMCitySelectVC.ymDelegate = self;
    [self.viewController presentViewController:YMCitySelectVC animated:YES completion:nil];
}
//YMCitySelectDelegate
- (void)ym_ymCitySelectCityName:(NSString *)cityName{
    [_addressButton setTitle:cityName forState:UIControlStateNormal];
}






@end
