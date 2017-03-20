//
//  QuestionAnswerViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QuestionAnswerViewController.h"
#import "QuestionAnswerTableView.h"
#import "UIImage+ZMExtension.h"

@interface QuestionAnswerViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) QuestionAnswerTableView *QATableView;
@property (nonatomic, strong) UIVisualEffectView *searchView;
@property (nonatomic, strong) UISearchBar *searchbar;

@end

@implementation QuestionAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"试题解答";
    self.view.backgroundColor = themeGray;
    
    [self setupSearchBar];
    [self setupQATableView];
}

/**
 *  搜索栏
 */
- (void)setupSearchBar{
    _searchView = [[UIVisualEffectView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];
    _searchView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    [self.view addSubview:self.searchView];
    [_searchView addSubview:self.searchbar];
}
- (UISearchBar *)searchbar{
    _searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(kScreenWidth * 0.1, (44 - 30)/2.0, kScreenWidth * 0.8, 30)];
    _searchbar.placeholder = @"查找试题答案";
    _searchbar.layer.cornerRadius = 15;
    _searchbar.layer.masksToBounds = YES;
    [_searchbar setBackgroundImage:[UIImage imageWithColor:themeWhite size:_searchbar.size]];
    [_searchbar setSearchFieldBackgroundImage:[UIImage imageWithColor:themeWhite size:_searchbar.size] forState:UIControlStateNormal];
    _searchbar.delegate = self;
    
    return _searchbar;
}
//UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%@",searchText);
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    [searchBar setShowsCancelButton:YES animated:YES];
    for (UIView *view in searchBar.subviews.firstObject.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
    
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"搜索");
    [searchBar resignFirstResponder];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}


/**
 *  QATableView
 */
- (void)setupQATableView{
    _QATableView = [[QuestionAnswerTableView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight - 44) style:UITableViewStylePlain];
    [self.view insertSubview:_QATableView belowSubview:_searchView];
}


@end
