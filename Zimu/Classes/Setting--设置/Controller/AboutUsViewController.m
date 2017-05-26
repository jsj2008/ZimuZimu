//
//  AboutUsViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AboutUsViewController.h"
#import "DeviceMessageModel.h"
#import "UIImage+ZMExtension.h"

@interface AboutUsViewController ()

@property (nonatomic, strong) UIView *bottomView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeGray;
    self.title = @"关于子慕";
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    
    [self _createBottomView];
    
    
}

//创建bottomView
- (void)_createBottomView{
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, kScreenWidth)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    //icon图片
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 80)/2, 30, 80, 80)];
    logoImageView.image = [UIImage imageNamed:@"App_icon"];
    logoImageView.layer.cornerRadius = 20;
    logoImageView.layer.masksToBounds = YES;
    [_bottomView addSubview:logoImageView];
    
    //APP名称
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImageView.frame) + 30, kScreenWidth, 20)];
    nameLabel.text = @"子慕";
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [_bottomView addSubview:nameLabel];
    
    //版本号
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame) + 10, kScreenWidth, 20)];
    NSString *versionString = [NSString stringWithFormat:@"版本 %@", [DeviceMessageModel GetAPPVersion]];
    versionLabel.text = versionString;
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = [UIFont systemFontOfSize:15];
    [_bottomView addSubview:versionLabel];
    
    //微信号
    NSString *textStr = @"微信公众号: 子慕亲子";
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize size = [textStr sizeWithAttributes:@{NSFontAttributeName:font}];
    UILabel *weTalkLabel = [[UILabel alloc]init];
    weTalkLabel.text = textStr;
    weTalkLabel.font = font;
    weTalkLabel.frame = CGRectMake((kScreenWidth - size.width)/2.0 + (25 + 2)/2.0, CGRectGetHeight(_bottomView.frame) - 50, size.width, 20);
    [_bottomView addSubview:weTalkLabel];
    UIImageView *wxImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(weTalkLabel.frame) - 25 - 2, kScreenWidth - 55, 25, 25)];
    wxImageView.image = [UIImage imageNamed:@"login_weixin"];
    weTalkLabel.centerY = wxImageView.centerY;
    [_bottomView addSubview:wxImageView];
    
    //公司名称
    UILabel *companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50 - 64, kScreenWidth, 20)];
    companyLabel.text = @"北京子慕教育咨询有限公司";
    companyLabel.textAlignment = NSTextAlignmentCenter;
    companyLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:companyLabel];
    
}




@end
