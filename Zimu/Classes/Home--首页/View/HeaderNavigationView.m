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

#define homeHeaderHeight 136

@interface HeaderNavigationView ()<UISearchBarDelegate>

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
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(-self.bounds.size.width + 80, (self.bounds.size.height - 20 - 30)/2.0 + 20, self.bounds.size.width - 100, 30)];
    _searchBar.placeholder = @"请输入咨询问题或专家名字";
    _searchBar.layer.cornerRadius = 15;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.delegate = self;
    [_searchBar setSearchFieldBackgroundImage:[UIImage imageWithColor:themeWhite size:_searchBar.bounds.size] forState:UIControlStateNormal];
    [_searchBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:_searchBar.bounds.size]];
    
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    searchField.textColor = [UIColor darkTextColor];
    [searchField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
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
    _addressButton = [[ListSelectButton alloc]initWithFrame:CGRectMake(10, (self.bounds.size.height - 20 - 30)/2.0 + 20, 60, 30) title:@"地址" imageName:@"icon_arrow" target:self action:@selector(selectAddress)];
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
                _searchBar.frame = CGRectMake(-self.bounds.size.width + 80, (self.bounds.size.height - 20 - 30)/2.0 + 20, self.bounds.size.width - 100, 30);
                _searchButton.alpha = 1;
                _scanButton.alpha = 1;
                
            } completion:^(BOOL finished) {
                _addressButton.hidden = YES;
            }];
        }else if (contentOffsetY >= homeHeaderHeight){
            //
            [UIView animateWithDuration:0.25 animations:^{
                _searchBar.frame = CGRectMake(80, (self.bounds.size.height - 20 - 30)/2.0 + 20, self.bounds.size.width - 100, 30);
                _searchButton.alpha = 1 - alphaValue;
                _scanButton.alpha  =1 - alphaValue;
            }completion:^(BOOL finished) {
                _addressButton.hidden = NO;
            }];
        }
    }
}

- (void)searchButtonAction{
    NSLog(@"search");
    TestViewController *testVC = [[TestViewController alloc]init];
    [self.viewController.navigationController pushViewController:testVC animated:YES];
}

- (void)scanButtonAction{
    NSLog(@"scan");
    
    TestViewController *testVC = [[TestViewController alloc]init];
    [self.viewController.navigationController presentViewController:testVC animated:YES completion:nil];
}

- (void)selectAddress{
    NSLog(@"selectAddress");
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = themeGray;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"去搜索");
    return NO;
}




@end
