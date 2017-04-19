//
//  CityCourseDetailViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CityCourseDetailViewController.h"
#import "CityCourseDetailTableView.h"
#import "UIView+SnailUse.h"
#import "PaymentChannelView.h"
#import "SnailQuickMaskPopups.h"

@interface CityCourseDetailViewController ()

@property (nonatomic, strong) CityCourseDetailTableView *tableView;
@property (nonatomic, strong) UIButton *buyButton;

@property (nonatomic, strong) SnailQuickMaskPopups *popup;

@end

@implementation CityCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"一城一课 • 杭州";
    self.view.backgroundColor = themeGray;
    
    [self setupTableView];
    [self setupBuyButton];
}


- (void)setupTableView{
    _tableView = [[CityCourseDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49)];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

- (void)setupBuyButton{
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyButton.frame = CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49);
    [_buyButton setBackgroundColor:themeYellow];
    [_buyButton setTitle:@"一键报名" forState:UIControlStateNormal];
    [_buyButton setTitleColor:themeWhite forState:UIControlStateNormal];
    _buyButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [_buyButton addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buyButton];
    
}

#pragma mark - 购买
- (void)buy{
    PaymentChannelView *view = [UIView paymentChannelView];
    view.price = @"100.00";
    _popup = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:view];
    _popup.isAllowPopupsDrag = YES;
    _popup.dampingRatio = 0.9;
    _popup.presentationStyle = PresentationStyleBottom;
    [_popup presentAnimated:YES completion:nil];
}


@end
