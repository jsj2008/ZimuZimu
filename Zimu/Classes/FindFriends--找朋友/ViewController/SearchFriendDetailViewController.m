//
//  SearchFriendDetailViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SearchFriendDetailViewController.h"
#import "UIImage+ZMExtension.h"
#import "SearchFriendResultViewController.h"

@interface SearchFriendDetailViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign)searchFriendStyle style;

//按条件查找陌生人
@property (nonatomic, strong) NSMutableArray *sexBtns;
@property (nonatomic, assign) NSInteger sexSelectIndex;
@property (nonatomic, strong) UITableView *agePlaceList;

@end

@implementation SearchFriendDetailViewController{
    UISearchBar * _searchBar;
}

- (instancetype)initWithStyle:(searchFriendStyle)style{
    self = [super init];
    if (self) {
        _style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = themeGray;
    if (_style == searchFriendStyleId) {
        self.title = @"查找好友";
    }else{
        self.title = @"按条件超找陌生人";
    }
    
    [self makeUI];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_style == searchFriendStyleId) {
        [_searchBar resignFirstResponder];
    }
}
#pragma mark - UI
- (void)makeUI{
    if (_style == searchFriendStyleId) {
        [self MakeSearchBar];
    }else{
        [self makeChoicesView];
    }
}

#pragma mark - 搜索
- (void)MakeSearchBar{

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 45)];
    bgView.backgroundColor = themeGray;
    [self.view addSubview:bgView];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    _searchBar.placeholder = @"请输入昵称/手机号";
    [_searchBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"f1f1f1"] size:_searchBar.size]];
    [_searchBar setSearchFieldBackgroundImage:[UIImage imageWithColor:themeWhite size:_searchBar.size] forState:UIControlStateNormal];
    _searchBar.delegate = self;
    _searchBar.tintColor = themeBlack;
    
    [bgView addSubview:_searchBar];
    
    [_searchBar becomeFirstResponder];

}
#pragma mark -----UISearchBarDelegate
//点击键盘上得search按钮 开始调用此方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //更新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        SearchFriendResultViewController *resultVC = [[SearchFriendResultViewController alloc] init];
        [self.navigationController pushViewController:resultVC animated:YES];
    });
    //让键盘失去第一响应者
    [searchBar resignFirstResponder];
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    cancelBtn.enabled = YES; //把enabled设置为yes
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return YES;
}
#pragma mark - 条件搜索
- (void)makeChoicesView{
    //白色背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 145)];
    bgView.backgroundColor = themeWhite;
    [self.view addSubview:bgView];
    
    CGFloat btnWidth = (kScreenWidth - 20) / 3 - 2;
    CGFloat btnHeight = 40;
    _sexBtns = [NSMutableArray array];
    NSArray *sexTitle = @[@"女", @"男", @"不限"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * (btnWidth + 1) + 10, 10, btnWidth, btnHeight);
        button.tag = i + 100;
        [button addTarget:self action:@selector(sexAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:sexTitle[i] forState:UIControlStateNormal];
        [button setTitle:sexTitle[i] forState:UIControlStateSelected];
        [button setTitleColor:themeBlack forState:UIControlStateNormal];
        [button setTitleColor:themeBlack forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"eeeeee"] size:CGSizeMake(btnWidth, btnHeight)] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"cccccc"] size:CGSizeMake(btnWidth, btnHeight)] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"cccccc"] size:CGSizeMake(btnWidth, btnHeight)] forState:UIControlStateHighlighted];
        [bgView addSubview:button];
        [_sexBtns addObject:button];
        
        if (button.tag == 100) {
            button.selected = YES;
        }
    }
    
    [bgView addSubview:self.agePlaceList];
    
    //查找按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(20, CGRectGetMaxY(bgView.frame) + 30, kScreenWidth - 40, 40) ;
    searchBtn.backgroundColor = [UIColor colorWithHexString:@"fedb18"];
    [searchBtn setTitle:@"查找" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchFriendAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
}
- (void)sexAction:(UIButton *)btn{
    for (int i = 0; i < _sexBtns.count; i ++) {
        UIButton *b = _sexBtns[i];
        if (b == btn) {
            b.selected = YES;
            _sexSelectIndex = i;
        }else{
            b.selected = NO;
        }
    }
    
    NSLog(@"%li", _sexSelectIndex);
}

- (void)searchFriendAction{
    NSLog(@"搜索");
}
#pragma mark - 年龄所在地
- (UITableView *)agePlaceList{
    if (!_agePlaceList) {
        _agePlaceList = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, 90) style:UITableViewStylePlain];
        _agePlaceList.scrollEnabled = NO;
        _agePlaceList.dataSource = self;
        _agePlaceList.delegate = self;
    }
    return _agePlaceList;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"48402"];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"666666"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"222222"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"年龄";
        cell.detailTextLabel.text = @"5-10岁";
    }else{
        cell.textLabel.text = @"所在地";
        cell.detailTextLabel.text = @"浙江-杭州";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%zd", indexPath.row);
}

@end
