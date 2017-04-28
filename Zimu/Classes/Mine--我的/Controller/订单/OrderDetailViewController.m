//
//  OrderDetailViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailTableView.h"
#import "UIView+SnailUse.h"
#import "PaymentChannelView.h"
#import "SnailQuickMaskPopups.h"

@interface OrderDetailViewController ()

@property (nonatomic, strong) OrderDetailTableView *orderDetailTableView;
@property (nonatomic, strong) UIButton *payButton;

@property (nonatomic, strong) SnailQuickMaskPopups *popup;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    self.view.backgroundColor = themeGray;
    
    [self setupOrderDetailTableView];
    [self setupPayButton];
}


/**
 *  orderDetailTableView
 */
- (void)setupOrderDetailTableView{
    _orderDetailTableView = [[OrderDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
    [self.view addSubview:_orderDetailTableView];
}

/**
 *  payButton
 */
- (void)setupPayButton{
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _payButton.frame = CGRectMake(0, CGRectGetMaxY(_orderDetailTableView.frame), kScreenWidth, 49);
    [_payButton setBackgroundColor:themeYellow];
    [_payButton setTitle:@"去付款" forState:UIControlStateNormal];
    [_payButton setTitleColor:themeWhite forState:UIControlStateNormal];
    _payButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_payButton addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payButton];
    
}

- (void)pay{
    PaymentChannelView *view = [UIView paymentChannelView];
    _popup = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:view];
    _popup.isAllowPopupsDrag = YES;
    _popup.dampingRatio = 0.9;
    _popup.presentationStyle = PresentationStyleBottom;
    [_popup presentAnimated:YES completion:nil];
}



@end
