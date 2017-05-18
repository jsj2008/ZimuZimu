//
//  MineViewController.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MineViewController.h"
#import "UIImage+ZMExtension.h"
#import "MineCollectionView.h"
#import "NewLoginViewController.h"
#import "MyInfoSetTableViewController.h"
#import "GetMyInfoAPI.h"
#import "MyInfoModel.h"
#import "MBProgressHUD+MJ.h"
#import <UIButton+WebCache.h>


@interface MineViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *headButton;     //头像
@property (nonatomic, strong) UILabel *nameLabel;       //姓名
@property (nonatomic, strong) UIButton *sexButton;      //性别年龄
@property (nonatomic, strong) UILabel *introLabel;      //一句话描述

@property (nonatomic, strong) MineCollectionView *mineCollectionView;

@property (nonatomic, strong) MyInfoModel *myInfoModel;


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.view.backgroundColor = themeWhite;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self makeUI];
    
    //获取信息数据
//    [self getMyInfoNetWork];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:themeYellow size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}


#pragma mark - UI
- (void)makeUI{
    [self setupScrollView];
    [self setupBannerView];
    [self setupContentView];
}

/**
 *  底层scrollView
 */
- (void)setupScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
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
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bannerImageView.frame), kScreenWidth, kScreenHeight - CGRectGetHeight(_bannerImageView.frame))];
    _contentView.backgroundColor = [UIColor colorWithHexString:@"fff8eb"];
    [_scrollView addSubview:_contentView];
    
    //头像
    _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _headButton.frame = CGRectMake(0, 0, 75 * kScreenWidth/375.0, 75 * kScreenWidth/375.0);
    _headButton.center = CGPointMake(_contentView.centerX, _contentView.y);
    _headButton.layer.cornerRadius = _headButton.height/2.0;
    _headButton.layer.masksToBounds = YES;
    [_headButton setImage:[UIImage imageNamed:@"wode_touxiang"] forState:UIControlStateNormal];
    [_headButton addTarget:self action:@selector(myInfo) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_headButton];
    
    //姓名
    NSString *name = @"蘇三的歌";
    UIFont *font = [UIFont boldSystemFontOfSize:18];
    CGSize nameSize = [name sizeWithAttributes:@{NSFontAttributeName:font}];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _headButton.height/2.0 + 10, nameSize.width, nameSize.height)];
    _nameLabel.centerX = _headButton.centerX;
    _nameLabel.text = name;
    _nameLabel.font = font;
    [_contentView addSubview:_nameLabel];
    
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
    [_contentView addSubview:_sexButton];
    
//    //一句话介绍
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
    CGFloat width = kScreenWidth - 50;
    CGFloat height = (width - 20)/3.0 * 2 + 15;
    _mineCollectionView = [[MineCollectionView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(_nameLabel.frame) + 35, kScreenWidth - 50, height) collectionViewLayout:[UICollectionViewFlowLayout new]];
    [_contentView addSubview:_mineCollectionView];
}

//我的个人信息
- (void)myInfo{
    
    MyInfoSetTableViewController *myInfoSetVC = [[MyInfoSetTableViewController alloc]init];
    myInfoSetVC.myInfoModel = _myInfoModel;
    [self.navigationController pushViewController:myInfoSetVC animated:YES];
}

- (void)login{
    NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
    [self presentViewController:newLoginVC animated:YES completion:nil];

}

#pragma mark - 获取我的信息数据
- (void)getMyInfoNetWork{
    GetMyInfoAPI *getMyInfoApi = [[GetMyInfoAPI alloc]init];
    NSLog(@"userToken : %@",userToken);
    [getMyInfoApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            return ;
        }
        NSLog(@"dataDic : %@",dataDic);
        NSInteger isTrue = [dataDic[@"isTrue"] integerValue];
        if (isTrue == 0) {
            return;
        }
        _myInfoModel = [MyInfoModel yy_modelWithDictionary:dataDic[@"object"]];
        [self refreshMyInfo];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"网络出错" toView:nil];
    }];
}

- (void)refreshMyInfo{
    //头像
    NSString *headImageString = _myInfoModel.userImg;
    [_headButton sd_setImageWithURL:[NSURL URLWithString:headImageString] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"wode_touxiang"]];
    
    //姓名
    NSString *name = _myInfoModel.userName;
    UIFont *font = [UIFont boldSystemFontOfSize:18];
    CGSize nameSize = [name sizeWithAttributes:@{NSFontAttributeName:font}];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _headButton.height/2.0 + 10, nameSize.width, nameSize.height)];
    _nameLabel.centerX = _headButton.centerX;
    
    //性别、年龄
    [_sexButton setImage:[UIImage imageNamed:@"mine_man"] forState:UIControlStateNormal];
    NSString *ageText = [NSString stringWithFormat:@" %@岁",_myInfoModel.age];
    font = [UIFont systemFontOfSize:13];
    CGSize sexSize = [ageText sizeWithAttributes:@{NSFontAttributeName:font}];
    _sexButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sexButton.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame) + 10, 0, sexSize.width + 20, sexSize.height + 10);
    _sexButton.centerY = _nameLabel.centerY;
    [_sexButton setTitle:ageText forState:UIControlStateNormal];
    
}




@end
