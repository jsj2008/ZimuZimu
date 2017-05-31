//
//  PaymentChannelView.m
//  Zimu
//
//  Created by Redpower on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "PaymentChannelView.h"
#import "PaymentChannelTableView.h"
#import "ActivityApplyInfoView.h"
/*提交订单*/
#import "WXOfflineCourseApi.h"
#import "MBProgressHUD+MJ.h"
#import "ZimuPayManager.h"
#import "UIView+ViewController.h"

@interface PaymentChannelView ()<PaymentChannelDelegate, ZimuPayManagerDelegate>

@property (nonatomic, strong) ActivityApplyInfoView *orderInfoView;
@property (nonatomic, strong) PaymentChannelTableView *paymentChannelTableView;
@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, assign) BOOL selectedChannel;     //是否已选择支付方式
@property (nonatomic, copy) NSString *channel;      //付款方式 wx/alipay

@end

@implementation PaymentChannelView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _selectedChannel = NO;
        self.backgroundColor = themeWhite;
        [self addSubview:self.orderInfoView];
        [self addSubview:self.paymentChannelTableView];
        [self addSubview:self.payButton];
    }
    return self;
}

- (ActivityApplyInfoView *)orderInfoView{
    if (!_orderInfoView) {
        _orderInfoView = [[ActivityApplyInfoView alloc]initWithFrame:CGRectMake(0, 0, self.width, 130)];
    }
    return _orderInfoView;
}

- (PaymentChannelTableView *)paymentChannelTableView{
    if (!_paymentChannelTableView) {
        _paymentChannelTableView = [[PaymentChannelTableView alloc]initWithFrame:CGRectMake(0, 130, self.width, self.height - 130 - 49) style:UITableViewStylePlain];
        _paymentChannelTableView.scrollEnabled = NO;
        _paymentChannelTableView.channelDelegate = self;
    }
    return _paymentChannelTableView;
}

//PaymentChannelDelegate
- (void)selectPaymentChannel:(NSString *)channel{
    NSLog(@"%@",channel);
    _channel = channel;
    _selectedChannel = YES;
    [_payButton setBackgroundColor:[UIColor colorWithHexString:@"F5CD13"]];
    _payButton.enabled = YES;
}

- (UIButton *)payButton{
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.frame = CGRectMake(0, self.height - 49, self.width, 49);
        [_payButton setBackgroundColor:[UIColor colorWithHexString:@"999999"]];
        _payButton.enabled = NO;
        NSString *titleString = @"确认支付";
        [_payButton setTitle:titleString forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

/**
 *  支付
 */
- (void)pay{
    [self submitOrder];
    NSLog(@"pay : %@",_paymentChannelTableView.channel);
}

- (void)setPrice:(NSString *)price{
    if (_price != price) {
        _price = price;
        NSString *titleString = [NSString stringWithFormat:@"确认支付 ￥%@",price];//@"确认支付 ￥1.00";
        NSMutableAttributedString *titleAttributedString = [[NSMutableAttributedString alloc]initWithString:titleString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:themeWhite}];
        [titleAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(5, titleString.length - 5)];
        [_payButton setAttributedTitle:titleAttributedString forState:UIControlStateNormal];
        
    }
}

- (void)setPaymentInfoModel:(PaymentInfoModel *)paymentInfoModel{
    _paymentInfoModel = paymentInfoModel;
    _orderInfoView.paymentInfoModel = paymentInfoModel;
    
    //价格
    NSString *titleString = [NSString stringWithFormat:@"确认支付 ￥%@",paymentInfoModel.price];
    NSMutableAttributedString *titleAttributedString = [[NSMutableAttributedString alloc]initWithString:titleString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:themeWhite}];
    [titleAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(5, titleString.length - 5)];
    [_payButton setAttributedTitle:titleAttributedString forState:UIControlStateNormal];
}


#pragma mark - 提交订单
- (void)submitOrder{
    
    ZimuPayManager *manager = [[ZimuPayManager alloc]init];
    manager.delegate = self;
    if (_chargePay) {
        if (_charge.length == 0) {
            [MBProgressHUD showMessage_WithoutImage:@"订单失效，请重新下单" toView:nil];
            return;
        }
        [manager normalPayWithViewController:self.viewController charge:_charge];
    }else{
        [manager normalPayWithViewController:self.viewController PaymentInfoModel:_paymentInfoModel channel:_channel];
    }
    
//    WXOfflineCourseApi *wxOfflineCourseApi = [[WXOfflineCourseApi alloc]initWithOfflineCourseId:_paymentInfoModel.courseId offCoursePrice:_paymentInfoModel.price channel:_channel];
//    [wxOfflineCourseApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSData *data = request.responseData;
//        NSError *error = nil;
//        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//        if (error) {
//            [MBProgressHUD showMessage_WithoutImage:@"数据出错，请稍后再试" toView:self];
//            return ;
//        }
//        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
//        if (!isTrue) {
//            [MBProgressHUD showMessage_WithoutImage:@"订单创建失败" toView:self];
//            return;
//        }
//        [MBProgressHUD showSuccess:@"订单提交成功" toView:self];
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [MBProgressHUD showMessage_WithoutImage:@"网络错误，请稍后再试" toView:self];
//    }];
}

#pragma mark - ZimuPayManagerDelegate
- (void)zimuPayManager:(ZimuPayManager *)manager finishPay:(NSString *)result{
//    [MBProgressHUD showSuccess:result toView:self];
    NSLog(@"result : %@",result);
    
    if ([self.delegate respondsToSelector:@selector(paymentViewFinishPayWithResult:)]) {
        [self.delegate paymentViewFinishPayWithResult:result];
    }
    
}

- (void)loginFailed{
    if ([self.delegate respondsToSelector:@selector(loginFailed)]) {
        [self.delegate loginFailed];
    }
}

@end

/*
 1.生成订单信息，提交至服务器；
 2. 提交成功，调用ping++付款
    提交失败，请稍后再试
 3. 付款成功，成功页面
    付款失败，失败页面，重新支付
 */
