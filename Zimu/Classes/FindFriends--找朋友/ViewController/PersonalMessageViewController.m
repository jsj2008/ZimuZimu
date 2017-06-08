//
//  MineViewController.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "PersonalMessageViewController.h"
#import "UIImage+ZMExtension.h"
#import "MineCollectionView.h"
#import "PersonalFunctionView.h"
#import "ZM_CallingHandleCategory.h"
#import "CreateChatRoomApi.h"
#import "GetFriendMsgApi.h"
#import "MBProgressHUD+MJ.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "ZMBlankView.h"
#import "NewLoginViewController.h"

@interface PersonalMessageViewController ()<LoginViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *headButton;     //头像
@property (nonatomic, strong) UILabel *nameLabel;       //姓名
@property (nonatomic, strong) UIButton *sexButton;      //性别年龄
@property (nonatomic, strong) UILabel *introLabel;      //一句话描述

@property (nonatomic, strong) PersonalFunctionView *personalFunView;

@end

@implementation PersonalMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"我的";
    self.view.backgroundColor = themeWhite;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self makeUI];
    [self getFriendMsg];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}


#pragma mark - UI
- (void)makeUI{
    [self setupScrollView];
//    [self setupBannerView];
//    [self setupContentView];
}

/**
 *  底层scrollView
 */
- (void)setupScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _scrollView.backgroundColor = [UIColor colorWithHexString:@"f8c548"];
    [self.view addSubview:_scrollView];
}

/*banner*/
- (void)setupBannerView{
    _bannerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 215 * kScreenWidth / 375.0)];
    _bannerImageView.image = [UIImage imageNamed:@"mine_toubu"];
    [_scrollView addSubview:_bannerImageView];
}

/*contentView*/
- (void)setupContentView{
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(25, 145, kScreenWidth - 50, kScreenHeight - 145 - 64)];
    _contentView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    _contentView.layer.cornerRadius = 10;
//    _contentView.layer.masksToBounds = YES;
    [_scrollView addSubview:_contentView];
    
    //头像
    _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _headButton.frame = CGRectMake(0, 0, 75 * kScreenWidth/375.0, 75 * kScreenWidth/375.0);
    _headButton.center = CGPointMake(_scrollView.centerX, 145);
    _headButton.layer.cornerRadius = _headButton.height/2.0;
    _headButton.layer.masksToBounds = YES;
    [_headButton setImage:[UIImage imageNamed:@"wode_touxiang"] forState:UIControlStateNormal];
//    [_headButton addTarget:self action:@selector(myInfo) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_headButton];
    
    //姓名
    NSString *name = @"蘇三的歌";
    UIFont *font = [UIFont boldSystemFontOfSize:18];
    CGSize nameSize = [name sizeWithAttributes:@{NSFontAttributeName:font}];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headButton.frame) + 10, nameSize.width, nameSize.height)];
    _nameLabel.centerX = _headButton.centerX;
    _nameLabel.text = name;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = font;
    [_scrollView addSubview:_nameLabel];
    
    //性别年龄
    NSString *oldText = @" 100岁";
    font = [UIFont systemFontOfSize:13];
    CGSize sexSize = [oldText sizeWithAttributes:@{NSFontAttributeName:font}];
    _sexButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sexButton.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame) + 10, 0, sexSize.width + 20, sexSize.height + 10);
    _sexButton.centerY = _nameLabel.centerY;
    [_sexButton setTitle:oldText forState:UIControlStateNormal];
    [_sexButton setTitleColor:themeWhite forState:UIControlStateNormal];
    _sexButton.titleLabel.font = font;
    [_sexButton setImage:[UIImage imageNamed:@"mine_women"] forState:UIControlStateNormal];
    [_sexButton setBackgroundImage:[UIImage imageNamed:@"mine_nianling"] forState:UIControlStateNormal];
    _sexButton.enabled = NO;
    [_scrollView addSubview:_sexButton];
    
    //一句话介绍
//    NSString *introText = @"乱纷纷 像一首朦胧诗  懵懂懂 才懂得朦胧美\n什么事是非  都似是而非";
//    font = [UIFont systemFontOfSize:14];
//    _introLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameLabel.frame) + 15, kScreenWidth - 20, 40)];
//    _introLabel.font = font;
//    _introLabel.numberOfLines = 2;
//    _introLabel.text = introText;
//    _introLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    _introLabel.textAlignment = NSTextAlignmentCenter;
//    [_contentView addSubview:_introLabel];
    
    /*mineCollectionView*/
//    CGFloat width =  2 * (kScreenWidth - 50 - 20)/3.0 + 20;
//    CGFloat height = (width - 20)/3.0 * 2 + 15;
//    _personalFunView = [[PersonalFunctionView alloc]initWithFrame:CGRectMake((kScreenWidth - width) / 2, CGRectGetMaxY(_introLabel.frame) + 25, width, height) collectionViewLayout:[UICollectionViewFlowLayout new]];
//    _personalFunView.isFriend = YES;
//    [_contentView addSubview:_personalFunView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(22, _contentView.height - 33 - 45, _contentView.width - 44, 45);
    button.backgroundColor = [UIColor colorWithHexString:@"a0e232"];
    if (_isFriend == YES) {
        [button setTitle:@"视频聊天" forState:UIControlStateNormal];
    }else{
        [button setTitle:@"加为好友" forState:UIControlStateNormal];
    }
    button.layer.cornerRadius = 23.5;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(friendBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:button];
}

- (void)friendBtnAction:(UIButton *)btn{
    if (_isFriend == YES) {
//        ZM_CallingHandleCategory *call = [[ZM_CallingHandleCategory alloc] initWithRole:ZMChatRoleSingleChief];
//        [call jumpToChatRoom];
        [self createSingleChatRoom];
    }else{
        NSLog(@"加为好友");
    }
}

#pragma mark - 网络请求
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFriendMsg];
    }];
    [self.view addSubview:blankview];
}

- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFriendMsg];
    }];
    [self.view addSubview:blankview];
}
- (void)timeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFriendMsg];
    }];
    [self.view addSubview:blankview];
}
- (void)lostSever{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFriendMsg];
    }];
    [self.view addSubview:blankview];
}


- (void)getFriendMsg{
    GetFriendMsgApi *getHomeSixImageApi = [[GetFriendMsgApi alloc]initWithUserId:_userId];
    [getHomeSixImageApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
//            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.view];
            [self lostSever];
            return ;
        }else{
            //设置头像
            NSString *imgUrlStr = dataDic[@"object"][@"userImg"];
            if (![imgUrlStr isEqualToString:@""] ||!imgUrlStr) {
                [self noData];
            }else{
                BOOL isTrue = [dataDic[@"isTrue"] boolValue];
                if (!isTrue) {
                    [self login];
                    return;
                }
                [self setupContentView];
                imgUrlStr = [imagePrefixURL stringByAppendingString:imgUrlStr];
                [_headButton sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"mine_head_placeholder"]];
                //
                _nameLabel.text =  dataDic[@"object"][@"userName"];
                //
                self.title = dataDic[@"object"][@"userName"];
                if ([dataDic[@"object"][@"userSex"] integerValue] == 0) {
                    [_sexButton setImage:[UIImage imageNamed:@"mine_women"] forState:UIControlStateNormal];
                    [_sexButton setBackgroundImage:[UIImage imageNamed:@"mine_nianling"] forState:UIControlStateNormal];
                }else{
                    [_sexButton setImage:[UIImage imageNamed:@"mine_man"] forState:UIControlStateNormal];
                    [_sexButton setBackgroundImage:[UIImage imageNamed:@"mine_nianling"] forState:UIControlStateNormal];
                }
                NSString *age = [NSString stringWithFormat:@"  %li岁", [dataDic[@"object"][@"age"] integerValue] ];
                [_sexButton setTitle:age forState:UIControlStateNormal];
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

- (void)createSingleChatRoom{

    ZM_CallingHandleCategory *call = [ZM_CallingHandleCategory shareInstance];
    call.role = ZMChatRoleSingleChief;
    call.users = _userId;
    [call startChat];


}
@end
