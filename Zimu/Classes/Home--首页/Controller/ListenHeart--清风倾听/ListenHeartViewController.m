//
//  ListenHeartViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ListenHeartViewController.h"
#import "ListenHeartTableView.h"
#import "UIView+SnailUse.h"
#import "PaymentChannelView.h"
#import "SnailQuickMaskPopups.h"

@interface ListenHeartViewController ()

@property (nonatomic, strong) ListenHeartTableView *listenHeartTableView;
@property (nonatomic, strong) SnailQuickMaskPopups *popup;

@end

@implementation ListenHeartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"清风倾听";
    self.view.backgroundColor = themeGray;
    
    [self setupListenHeartTableView];
    
    [self setupCallPhoneView];
}

- (void)setupListenHeartTableView{
    _listenHeartTableView = [[ListenHeartTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    [self.view addSubview:_listenHeartTableView];
}

- (void)setupCallPhoneView{
    UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    callButton.frame = CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49);
    [callButton setBackgroundColor:[UIColor colorWithHexString:@"FBBF38"]];
    [callButton setTitle:@"一键咨询" forState:UIControlStateNormal];
    [callButton setTitleColor:themeWhite forState:UIControlStateNormal];
    [callButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    callButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [callButton addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:callButton];
}

- (void)callPhone{
    PaymentChannelView *view = [UIView paymentChannelView];
    _popup = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:view];
    _popup.isAllowPopupsDrag = YES;
    _popup.dampingRatio = 0.9;
    _popup.presentationStyle = PresentationStyleBottom;
    [_popup presentAnimated:YES completion:nil];
    
}

@end
