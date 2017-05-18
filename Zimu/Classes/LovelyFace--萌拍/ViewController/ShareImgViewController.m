//
//  ShareImgViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ShareImgViewController.h"
#import "ZMShareManager.h"
#import "UIImage+ZMExtension.h"
#import "UIBarButtonItem+ZMExtension.h"

@interface ShareImgViewController ()

@end

@implementation ShareImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    UIColor *naviColor = [UIColor colorWithHexString:@"f5ce13"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:naviColor size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UIBarButtonItem *msgBtn = [UIBarButtonItem barButtonItemWithImageName:@"backHome" title:@"" target:self action:@selector(backToHome)];

    self.navigationItem.rightBarButtonItem = msgBtn;
}

#pragma mark - 返回首页
- (void)backToHome{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 分享图片
- (IBAction)shareToQQ:(id)sender {
    ZMShareManager  *share = [[ZMShareManager alloc] init];
    [share shareImageToPlatformType:UMSocialPlatformType_QQ image:_img];
}
- (IBAction)shareToWX:(id)sender {
    ZMShareManager  *share = [[ZMShareManager alloc] init];
    [share shareImageToPlatformType:UMSocialPlatformType_WechatSession image:_img];
}
- (IBAction)shareToPYQ:(id)sender {
    ZMShareManager  *share = [[ZMShareManager alloc] init];
    [share shareImageToPlatformType:UMSocialPlatformType_WechatTimeLine image:_img];
}


@end
