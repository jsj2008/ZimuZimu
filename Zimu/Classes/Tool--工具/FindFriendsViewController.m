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

#import "ZM_FriendsListView.h"
#import "ZM_MutiplyClickButton.h"

#import "UIBarButtonItem+ZMExtension.h"
#import "UIImage+ZMExtension.h"
#import "SnailQuickMaskPopups.h"
#import "UIView+SnailUse.h"
#import "ZM_SelectSexView.h"

@interface FindFriendsViewController ()<ZM_MutiplyClickButtonDelegate, ZMFriendDelagate, FriendsMsgDelegate>

//第一次进入弹出的界面
@property (nonatomic, strong) SnailQuickMaskPopups *popups;
@property (nonatomic, strong) ZM_SelectSexView *msgView;

//列表视图
@property (nonatomic, strong) ZM_FriendsListView *listView;
//选择好友按钮
@property (nonatomic, strong) ZM_MutiplyClickButton *chooseBtn;

@end

@implementation FindFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f3f7"];
    self.title = @"找朋友";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIColor *naviColor = [UIColor colorWithHexString:@"f5ce13"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:naviColor size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.view.backgroundColor = themeWhite;
    [self setUI];
    
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
    
    //好友列表
    if (!_listView) {
        _listView = [[ZM_FriendsListView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight - 45) collectionViewLayout:[UICollectionViewFlowLayout new]];
        _listView.backgroundColor = [UIColor colorWithHexString:@"f2f3f7"];
        NSArray *array = @[@{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"},@{@"name":@"李曼婷",@"heasdimg":@"find_topic_4" },@{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"},@{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"},@{@"name":@"李曼婷", @"heasdimg":@"find_topic_4"  },@{@"name":@"李曼婷", @"heasdimg":@"find_topic_4" }, @{@"name":@"李曼婷", @"heasdimg":@"find_topic_4"}, @{@"name":@"李曼婷", @"heasdimg":@"find_topic_4"  }, @{@"name":@"李曼婷", @"heasdimg":@"find_topic_4" }, @{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"}, @{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"}, @{@"name":@"李曼婷", @"heasdimg":@"find_topic_4"}, @{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"},@{@"name":@"李曼婷",@"heasdimg":@"find_topic_4" },@{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"},@{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"},@{@"name":@"李曼婷", @"heasdimg":@"find_topic_4"  },@{@"name":@"李曼婷", @"heasdimg":@"find_topic_4" }, @{@"name":@"李曼婷", @"heasdimg":@"find_topic_4"}, @{@"name":@"李曼婷", @"heasdimg":@"find_topic_4"  }, @{@"name":@"李曼婷", @"heasdimg":@"find_topic_4" }, @{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"}, @{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"}, @{@"name":@"李曼婷", @"heasdimg":@"find_topic_4"}, @{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"},@{@"name":@"李曼婷",@"heasdimg":@"find_topic_4" },@{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"},@{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"},@{@"name":@"李曼婷", @"heasdimg":@"find_topic_4"  },@{@"name":@"李曼婷", @"heasdimg":@"find_topic_4" }, @{@"name":@"李曼婷", @"heasdimg":@"find_topic_4"}, @{@"name":@"李曼婷", @"heasdimg":@"find_topic_4"  }, @{@"name":@"李曼婷", @"heasdimg":@"find_topic_4" }, @{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"}, @{@"name":@"李曼婷",@"heasdimg":@"find_topic_4"}, @{@"name":@"李曼婷", @"heasdimg":@"find_topic_4" }];
        _listView.dataArray = array;
        _listView.showsVerticalScrollIndicator = NO;
        _listView.selectMoreDelegate = self;
        [self.view addSubview:_listView];
    }
    //选择好友按钮
    if (!_chooseBtn) {
        NSArray *btnAry = @[@"选择多个好友", @"开始聊天"];
        
        _chooseBtn = [[ZM_MutiplyClickButton alloc] initWithDataSource:btnAry];
        _chooseBtn.frame = CGRectMake(kScreenWidth / 2 - 100, kScreenHeight - 35 - 40 - 55, 200, 40);
        
        _chooseBtn.delegate = self;
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
    [self rightNavBtns];
}

//搜索点击事件
- (void)searchAction{
    FriendSearchViewController *searchVC = [[FriendSearchViewController alloc] init];
    [self presentViewController:searchVC animated:YES completion:nil];
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
    SearchFriendsViewController *searchVC = [[SearchFriendsViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
}
- (void)noneAction{
    
}

#pragma mark - 按钮点击后的代理，用于在每个状态下的事件处理
- (void)didClickBtnWithIndex:(NSInteger)index{
    if (index == 0) {
        NSLog(@"选择朋友");
        _listView.state = chooseStateChoosing;
    }else if (index == 1){
        NSLog(@"开始聊天");
    }
}

#pragma mark - 选择朋友代理
- (void)didSelectItems:(NSDictionary *)items{
    NSLog(@"%@", items);
}

- (void)watchFriendDetailWithIndex:(NSInteger)index{
//    NSLog(@"%zd", index);
    [self seeFriendDetail:index];
}

- (void)seeFriendDetail:(NSInteger)index{
    PersonalMessageViewController *detailVC = [[PersonalMessageViewController alloc] init];
    detailVC.title = [NSString stringWithFormat:@"%zd", index];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
