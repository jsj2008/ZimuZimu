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
#import "ZM_FriendsListView.h"
#import "ZM_MutiplyClickButton.h"

#import "SnailQuickMaskPopups.h"

@interface FindFriendsViewController ()<ZM_MutiplyClickButtonDelegate, ZMFriendDelagate>

@property (nonatomic, strong) ZM_FriendsListView *listView;
@property (nonatomic, strong) ZM_MutiplyClickButton *chooseBtn;

@end

@implementation FindFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = themeWhite;
    
    [self setUI];

}

#pragma mark - 绘制UI
- (void)setUI{
    //搜索按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(20, 84, kScreenWidth - 40, 40);
    searchBtn.layer.cornerRadius = 20;
    searchBtn.layer.borderColor = [UIColor colorWithHexString:@"adadad"].CGColor;
    searchBtn.layer.borderWidth = 1;
    [searchBtn setTitleColor:[UIColor colorWithHexString:@"adadad"] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [searchBtn setTitle:@"输入好友昵称" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    //好友列表
    if (!_listView) {
        _listView = [[ZM_FriendsListView alloc] initWithFrame:CGRectMake(20, 144, kScreenWidth - 40, kScreenHeight - 144 - 75 - 35) collectionViewLayout:[UICollectionViewFlowLayout new]];
        _listView.backgroundColor = themeWhite;
        NSArray *array = @[@{@"name":@"张三",@"heasdimg":@"find_topic_4"},@{@"name":@"张三",@"heasdimg":@"find_topic_4" },@{@"name":@"张三",@"heasdimg":@"find_topic_4"},@{@"name":@"张三",@"heasdimg":@"find_topic_4"},@{@"name":@"张三", @"heasdimg":@"find_topic_4"  },@{@"name":@"张三", @"heasdimg":@"find_topic_4" }, @{@"name":@"张三", @"heasdimg":@"find_topic_4"}, @{@"name":@"张三", @"heasdimg":@"find_topic_4"  }, @{@"name":@"张三", @"heasdimg":@"find_topic_4" }, @{@"name":@"张三",@"heasdimg":@"find_topic_4"}, @{@"name":@"张三",@"heasdimg":@"find_topic_4"}, @{@"name":@"张三", @"heasdimg":@"find_topic_4"}, @{@"name":@"张三",@"heasdimg":@"find_topic_4"},@{@"name":@"张三",@"heasdimg":@"find_topic_4" },@{@"name":@"张三",@"heasdimg":@"find_topic_4"},@{@"name":@"张三",@"heasdimg":@"find_topic_4"},@{@"name":@"张三", @"heasdimg":@"find_topic_4"  },@{@"name":@"张三", @"heasdimg":@"find_topic_4" }, @{@"name":@"张三", @"heasdimg":@"find_topic_4"}, @{@"name":@"张三", @"heasdimg":@"find_topic_4"  }, @{@"name":@"张三", @"heasdimg":@"find_topic_4" }, @{@"name":@"张三",@"heasdimg":@"find_topic_4"}, @{@"name":@"张三",@"heasdimg":@"find_topic_4"}, @{@"name":@"张三", @"heasdimg":@"find_topic_4"}, @{@"name":@"张三",@"heasdimg":@"find_topic_4"},@{@"name":@"张三",@"heasdimg":@"find_topic_4" },@{@"name":@"张三",@"heasdimg":@"find_topic_4"},@{@"name":@"张三",@"heasdimg":@"find_topic_4"},@{@"name":@"张三", @"heasdimg":@"find_topic_4"  },@{@"name":@"张三", @"heasdimg":@"find_topic_4" }, @{@"name":@"张三", @"heasdimg":@"find_topic_4"}, @{@"name":@"张三", @"heasdimg":@"find_topic_4"  }, @{@"name":@"张三", @"heasdimg":@"find_topic_4" }, @{@"name":@"张三",@"heasdimg":@"find_topic_4"}, @{@"name":@"张三",@"heasdimg":@"find_topic_4"}, @{@"name":@"张三", @"heasdimg":@"find_topic_4"}];
        _listView.dataArray = array;
        _listView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_listView];
    }
    //选择好友按钮
    if (!_chooseBtn) {
        NSArray *btnAry = @[@"发起聊天", @"开始聊天"];
        
        _chooseBtn = [[ZM_MutiplyClickButton alloc] initWithDataSource:btnAry];
        _chooseBtn.frame = CGRectMake(kScreenWidth / 2 - 100, kScreenHeight - 35 - 40, 200, 40);
        
        _chooseBtn.delegate = self;
        _chooseBtn.backgroundColor = themeYellow;
//        [_chooseBtn addTarget:self action:@selector(startViewAction) forControlEvents:UIControlEventTouchUpInside];
        _chooseBtn.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        _chooseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        _chooseBtn.layer.cornerRadius = 20;
        [self.view addSubview:_chooseBtn];
    }
    
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

- (void)searchAction{
    NSLog(@"搜索");
//    PLMediaViewerPKViewController *controller = [[PLMediaViewerPKViewController alloc] init];
//    controller.userType = PLMediaUserPKTypeSecondChief;
//    controller.roomName = @"124";
//    [self.navigationController pushViewController:controller animated:NO];
    
//    PLMediaChiefPKViewController *controller1 = [[PLMediaChiefPKViewController alloc] init];
//    controller1.roomName = @"124";
//    [self.navigationController pushViewController:controller1 animated:NO];

}

@end
