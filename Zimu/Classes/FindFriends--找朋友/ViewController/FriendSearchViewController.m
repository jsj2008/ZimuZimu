//
//  FriendSearchViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FriendSearchViewController.h"
#import "UIImage+ZMExtension.h"
#import "ZMFriendSearchResultCell.h"

static NSString *searchResultCellId = @"ZMFriendSearchResultCell";

@interface FriendSearchViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    NSMutableArray * _subDataArray;
    UISearchBar * _searchBar;
}
@end

@implementation FriendSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configTableView];
    [self configSearchBar];
    
}

#pragma mark - UI
- (void)configSearchBar{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 64)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"f5ce13"];
    [self.view addSubview:bgView];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(8, 30, kScreenWidth - 16, 25)];
    _searchBar.placeholder = @"搜索";
    [_searchBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"f5ce13"] size:_searchBar.size]];
    [_searchBar setSearchFieldBackgroundImage:[UIImage imageWithColor:themeWhite size:_searchBar.size] forState:UIControlStateNormal];
    _searchBar.delegate = self;
    
    _searchBar.tintColor = themeBlack;
    for (UIView *subView in [[_searchBar.subviews lastObject] subviews]) {
        if ([[subView class] isSubclassOfClass:[UITextField class]]) { // 是UItextField
            // 设置UItextField的圆角
            UITextField *textField = (UITextField *)subView;
            textField.layer.cornerRadius = 6;
            textField.layer.masksToBounds = YES;
            // 退出循环
            break;
        }
    }
    //设置搜索框外面的 完成 按钮
    [_searchBar setShowsCancelButton:YES animated:YES];
    for (UIView *view in _searchBar.subviews.firstObject.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setTitleColor:themeBlack forState:UIControlStateNormal];
            [button setTitle:@"取消" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
    }

    [bgView addSubview:_searchBar];
    
    [_searchBar becomeFirstResponder];
}

- (void) configTableView {
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    CGRect tableViewFrame = CGRectMake(0, 55, width, height - 55);
    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tableFooterView = [[UIView alloc] init];
    //注册单元格
    UINib *nib  = [UINib nibWithNibName:searchResultCellId bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:searchResultCellId];
    //备份数据源
    _dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 100; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"%i", i]];
    }
    //数据源
    _subDataArray = [[NSMutableArray alloc] initWithArray:_dataArray];
}


#pragma mark UISearchBarDelegate
//点击键盘上得search按钮 开始调用此方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //清空数据源
    NSString * getStr = searchBar.text;
    //从备份数据源查找符合条件的数据，并加入到数据源中
    for (int i = 0; i < _subDataArray.count; i ++) {
        _subDataArray[i] = getStr;
    }
    //更新UI
    [_tableView reloadData];
    //让键盘失去第一响应者
    [searchBar resignFirstResponder];
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    cancelBtn.enabled = YES; //把enabled设置为yes
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self back];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return YES;
}


//按钮点击事件
- (void)back{
     [_searchBar resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _subDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMFriendSearchResultCell * cell = [tableView dequeueReusableCellWithIdentifier:searchResultCellId];

    cell.separatorInset = UIEdgeInsetsZero;
    cell.nameString = [NSString stringWithFormat:@"%@ %zd", _subDataArray[indexPath.row], indexPath.row];
    cell.idString = @"12987u5";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


@end
