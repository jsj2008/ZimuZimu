//
//  FindFriendsViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindFriendsViewController.h"
#import "PLMediaChiefPKViewController.h"
#import "PLMediaViewerPKViewController.h"
#import "SecondViewController.h"
#import "FriendSearchViewController.h"
#import "PersonalMessageViewController.h"
#import "FriendsMsgViewController.h"
#import "SearchFriendsViewController.h"
#import "SearchFriendDetailViewController.h"
#import "GetFriendsListApi.h"
#import "NewLoginViewController.h"
#import "FriendListModel.h"

#import "ZM_FriendsListView.h"
#import "ZM_MutiplyClickButton.h"

#import "MBProgressHUD+MJ.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "UIImage+ZMExtension.h"
#import "SnailQuickMaskPopups.h"
#import "UIView+SnailUse.h"
#import "ZM_SelectSexView.h"
#import "ZM_CallingHandleCategory.h"
#import "ZMBlankView.h"

@interface FindFriendsViewController ()<ZMFriendDelagate, FriendsMsgDelegate>

//第一次进入弹出的界面
@property (nonatomic, strong) SnailQuickMaskPopups *popups;
@property (nonatomic, strong) ZM_SelectSexView *msgView;

//列表视图
@property (nonatomic, strong) ZM_FriendsListView *listView;
//选择好友按钮
@property (nonatomic, strong) UIButton *chooseBtn;

//用户列表信息
@property (nonatomic, strong) NSArray *friendListData;

@property (nonatomic, copy) NSString *selectedUsers;  //选中的用户id的拼接，逗号隔开
@end

@implementation FindFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f3f7"];
    self.title = @"找朋友";
    self.automaticallyAdjustsScrollViewInsets = NO;
//    UIColor *naviColor = [UIColor colorWithHexString:@"f5ce13"];         
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.view.backgroundColor = themeWhite;
    
    [self getFriendsList];
    [self setUI];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidAppear:(BOOL)animated{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        [self alert];
    });
}

#pragma mark - 第一次进入这个界面
- (void)alert{
    _msgView = [UIView sexChooseView];
    _msgView.delegate = self;
    _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_msgView];
    
//    _popups.isAllowPopupsDrag = YES;
    _popups.isAllowMaskTouch = NO;
    _popups.transitionStyle = TransitionStyleFromCenter;
    _popups.presentationStyle = PresentationStyleCentered;
    _popups.dampingRatio = 0.5;
    [_popups presentAnimated:YES completion:nil];
    
}
- (void)msgCollectEndedWithSex:(BOOL)sex age:(NSInteger)age{
    NSLog(@"%i   %li", sex, age);
    
    [_popups dismissAnimated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        NSLog(@"弹出框走了");
    }];
    _popups = nil;
    _msgView.delegate = nil;
    _msgView = nil;
}
#pragma mark - 绘制UI
- (void)setUI{
    //搜索按钮
    UIView *searchBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    searchBg.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [self.view addSubview:searchBg];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(10, 5, kScreenWidth - 20, 35);
    searchBtn.layer.cornerRadius = 5;
//    searchBtn.layer.borderColor = [UIColor colorWithHexString:@"adadad"].CGColor;
//    searchBtn.layer.borderWidth = 1;
    [searchBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [searchBtn setTitle:@"  搜索好友名称" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    searchBtn.backgroundColor = themeWhite;
    [searchBg addSubview:searchBtn];

    [self rightNavBtns];
}
- (void)setListWithData:(NSArray *)dataArray{
    //好友列表
    if (!_listView) {
        _listView = [[ZM_FriendsListView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight - 45) collectionViewLayout:[UICollectionViewFlowLayout new]];
        _listView.backgroundColor = [UIColor colorWithHexString:@"f2f3f7"];
        _listView.dataArray = dataArray;
        _friendListData = dataArray;
        _listView.showsVerticalScrollIndicator = NO;
        _listView.selectMoreDelegate = self;
        [self.view addSubview:_listView];
    }
    
    //选择好友按钮
    if (!_chooseBtn) {
        NSArray *btnAry = @[@"选择多个好友", @"开始聊天"];
        
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];//[[ZM_MutiplyClickButton alloc] initWithDataSource:btnAry];
        _chooseBtn.frame = CGRectMake(kScreenWidth / 2 - 100, kScreenHeight - 35 - 40 - 55, 200, 40);
        [_chooseBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
//        _chooseBtn.delegate = self;
         [_chooseBtn setTitle:@"选择多个好友" forState:UIControlStateNormal];
        _chooseBtn.backgroundColor = [UIColor colorWithHexString:@"f5cd13"];
        //        [_chooseBtn addTarget:self action:@selector(startViewAction) forControlEvents:UIControlEventTouchUpInside];
        _chooseBtn.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        _chooseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _chooseBtn.layer.shadowOffset =  CGSizeMake(1, 1);
        _chooseBtn.layer.shadowOpacity = 0.8;
        _chooseBtn.layer.shadowColor =  [UIColor colorWithHexString:@"333333"].CGColor;
        _chooseBtn.layer.cornerRadius = 20;
        [self.view addSubview:_chooseBtn];
    }
}

- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoFriend afterClickDestory:NO btnClick:^(ZMBlankView *blView) {
        [self addFriends];
    }];
    [self.view addSubview:blankview];
}

- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFriendsList];
    }];
    [self.view addSubview:blankview];
}
- (void)timeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFriendsList];
    }];
    [self.view addSubview:blankview];
}
- (void)lostSever{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFriendsList];
    }];
    [self.view addSubview:blankview];
}

//搜索点击事件
- (void)searchAction{
    FriendSearchViewController *searchVC = [[FriendSearchViewController alloc] init];
//    [self presentViewController:searchVC animated:YES completion:nil];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)rightNavBtns{
    UIBarButtonItem *msgBtn = [UIBarButtonItem barButtonItemWithImageName:@"friend_msg" title:@"" target:self action:@selector(msg)];
    UIBarButtonItem *addBItem = [UIBarButtonItem barButtonItemWithImageName:@"friend_add" title:@"" target:self action:@selector(addFriends)];
    //设置这个空按钮是为了隔开两个按钮的距离，并没有实际操作意义
    UIBarButtonItem *noneBtn = [UIBarButtonItem barButtonItemWithImageName:@"" title:@" " target:self action:@selector(noneAction)];
    self.navigationItem.rightBarButtonItems = @[addBItem, noneBtn,msgBtn];
}
- (void)msg{
    FriendsMsgViewController *msgVC = [[FriendsMsgViewController alloc] init];
    [self.navigationController pushViewController:msgVC animated:YES];
    NSLog(@"消息");
}
- (void)addFriends{
    NSLog(@"添加好友");
//    SearchFriendsViewController *searchVC = [[SearchFriendsViewController alloc] init];
//    [self.navigationController pushViewController:searchVC animated:YES];
    SearchFriendDetailViewController *searchDeVC = [[SearchFriendDetailViewController alloc] initWithStyle:searchFriendStyleId];
    [self.navigationController pushViewController:searchDeVC animated:YES];
    
}
- (void)noneAction{
    
}

#pragma mark - 按钮点击后的代理，用于在每个状态下的事件处理
- (void)didClickBtn:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"选择多个好友"]) {
        
        NSLog(@"选择朋友");
        [btn setTitle:@"开始聊天" forState:UIControlStateNormal];
        _listView.state = chooseStateChoosing;
    }else if ([btn.titleLabel.text isEqualToString:@"开始聊天"]){
        NSLog(@"开始聊天");
        _listView.state = chooseStateNormal;
        
        [btn setTitle:@"选择多个好友" forState:UIControlStateNormal];
        ZM_CallingHandleCategory *call = [ZM_CallingHandleCategory shareInstance];
        call.role = ZMChatRoleGroupChief;
        call.users = _selectedUsers;
        [call startChat];
        
        _selectedUsers = @"";
    }
}

#pragma mark - 选择朋友代理
- (void)didSelectItems:(NSDictionary *)items{
    _selectedUsers = @"";
    NSArray *keyAry = [items allKeys];
    for (int i = 0; i < keyAry.count; i ++) {
        NSDictionary *dic = items[keyAry[i]];
        FriendListModel *model = [FriendListModel yy_modelWithJSON:dic];
        if ([_selectedUsers isEqualToString:@""]) {
            _selectedUsers = model.userId;
        }else{
            _selectedUsers = [_selectedUsers stringByAppendingString:[NSString stringWithFormat:@",%@", model.userId]];
        }
    }
    NSLog(@"%@", _selectedUsers);
}

- (void)watchFriendDetailWithIndex:(NSInteger)index{
//    NSLog(@"%zd", index);
    [self seeFriendDetail:index];
}

- (void)seeFriendDetail:(NSInteger)index{
    PersonalMessageViewController *detailVC = [[PersonalMessageViewController alloc] init];
//    detailVC.title = [NSString stringWithFormat:@"%zd", index];
    FriendListModel *model = [FriendListModel yy_modelWithJSON:_friendListData[index]];
    detailVC.title = model.userName;
    detailVC.userId = model.userId;
    detailVC.isFriend = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 获取好友列表
- (void)getFriendsList{
    GetFriendsListApi *friendApi = [[GetFriendsListApi alloc] init];
//    friendApi.delegate = self;
    
    [friendApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.view];
            [self lostSever];
            return ;
        }else{
            BOOL isTrue = [dataDic[@"isTrue"] boolValue];
            if (!isTrue) {
                [self login];
                return;
            }
            NSArray *dataArray = dataDic[@"items"];
                if (dataArray.count == 0) {
                    [self noData];
                }else{
                    [self setListWithData:dataArray];
                }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (request.error.code == -1009) {
            [self noNet];
        }else if (request.error.code == -1011){
            [self timeOut];
        }else{
            [self lostSever];
        }
    }];
}

#pragma mark - 重新登录
- (void)login{
    //未登录，跳转至登录页
    NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
//    newLoginVC.delegate = self;
    [self presentViewController:newLoginVC animated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
//LoginViewControllerDelegate
//- (void)loginSuccess{
//    [self getFriendsList];
//}

@end
