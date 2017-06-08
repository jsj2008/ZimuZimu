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
#import "FriendProvinceTableViewController.h"
#import "SearchFriendByPhone.h"
#import "MBProgressHUD+MJ.h"
#import "ShareMyMsgViewController.h"

#import "SnailQuickMaskPopups.h"
#import "AgeRangeView.h"
#import "UIView+SnailUse.h"
#import "ZM_SelectSexView.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "NewLoginViewController.h"

@interface SearchFriendDetailViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, LoginViewControllerDelegate>

@property (nonatomic, assign)searchFriendStyle style;
//弹出的选择年龄
@property (nonatomic, strong) SnailQuickMaskPopups *popups;
@property (nonatomic, strong) AgeRangeView *ageChooseView;
//选择的搜索条件
@property (nonatomic, copy) NSString *ageRange;
@property (nonatomic, copy) NSString *address;
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
        self.title = @"添加好友";
    }else{
        self.title = @"按条件查找陌生人";
    }
    _address = @"全国";
    _ageRange = @"5-10";
    
    [self makeUI];
    [self setRightNav];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressDidchange:) name:@"ProvinceCityFriendNotification" object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_style == searchFriendStyleId) {
        [_searchBar resignFirstResponder];
    }
}
- (void)setRightNav{
    UIBarButtonItem *msgBtn = [UIBarButtonItem barButtonItemWithImageName:@"share" title:@"" target:self action:@selector(share:)];

    self.navigationItem.rightBarButtonItems = @[msgBtn];
}
- (void)share:(UIButton *)btn{
    ShareMyMsgViewController *faceVC =[[ShareMyMsgViewController alloc] initWithNibName:@"ShareMyMsgViewController" bundle:[NSBundle mainBundle]];
    //跳转事件
    [self.navigationController pushViewController:faceVC animated:NO];

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
    _searchBar.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _searchBar.tintColor = themeBlack;
    
    [bgView addSubview:_searchBar];
    
    [_searchBar becomeFirstResponder];

}
#pragma mark -----UISearchBarDelegate
//点击键盘上得search按钮 开始调用此方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    //让键盘失去第一响应者
    [searchBar resignFirstResponder];
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    cancelBtn.enabled = YES; //把enabled设置为yes
    NSString * getStr = searchBar.text;
    [self searchFriend:getStr];
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
        cell.detailTextLabel.text = [_ageRange stringByAppendingString:@"岁"];
    }else{
        cell.textLabel.text = @"所在地";
        cell.detailTextLabel.text = _address;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _ageChooseView) {
        return 60;
    }
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _ageChooseView) {
       NSString *ageRan = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        _ageRange = [ageRan substringToIndex:ageRan.length - 1];
        [_agePlaceList reloadData];
        [_popups dismissAnimated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
            NSLog(@"弹出框走了");
        }];
        _popups = nil;
        _ageChooseView.delegate = nil;
        _ageChooseView = nil;

    }else{
        if (indexPath.row == 0) {
            [self ageChoose];
        }else{
            FriendProvinceTableViewController *provinceVC = [[FriendProvinceTableViewController alloc] init];
            [self.navigationController pushViewController:provinceVC animated:YES];
        }
    }
    
}

#pragma mark - 选择信息
- (void)ageChoose{
    _ageChooseView = [UIView ageChooseView];
    _ageChooseView.delegate = self;
    _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_ageChooseView];
    _popups.isAllowMaskTouch = NO;
    _popups.transitionStyle = TransitionStyleFromBottom;
    _popups.presentationStyle = PresentationStyleBottom;
    _ageChooseView.delegate = self;
    [_popups presentAnimated:YES completion:nil];
}

- (void)addressDidchange:(NSNotification *)noti{
    NSDictionary *userInfo = noti.userInfo;
    _address = userInfo[@"addressNme"];
    [_agePlaceList reloadData];
    
    NSLog(@"%@", userInfo);
}

#pragma mark - 网络请求
- (void)searchFriend:(NSString *)friendPhone{
    SearchFriendByPhone *getHomeSixImageApi = [[SearchFriendByPhone alloc]initWithPhone:friendPhone];
    [getHomeSixImageApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.view];
            return ;
        }else{
            NSLog(@"搜索好友结果%@", dataDic);
            BOOL isTrue = [dataDic[@"isTrue"] boolValue];
            if (!isTrue) {
                [self login];
                [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
                return;
            }
            //更新UI
            SearchFriendResultViewController *resultVC = [[SearchFriendResultViewController alloc] init];
            resultVC.dataDic = dataDic[@"object"];
            [self.navigationController pushViewController:resultVC animated:YES];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.view];
    }];
}
- (void)login{
    //未登录，跳转至登录页
    NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
    newLoginVC.delegate = self;
    [self presentViewController:newLoginVC animated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
//LoginViewControllerDelegate
- (void)loginSuccess{
//    [self getFriendsList];
}
@end
