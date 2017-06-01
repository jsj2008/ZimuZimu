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
#import "QueryOffLineCourseOrderDetailApi.h"
#import "MBProgressHUD+MJ.h"
#import "OrderModel.h"
#import "NewLoginViewController.h"

@interface OrderDetailViewController ()<PaymentChannelViewDelegate>

@property (nonatomic, strong) OrderDetailTableView *orderDetailTableView;
@property (nonatomic, strong) UIButton *payButton;

@property (nonatomic, strong) OrderModel *orderModel;

@property (nonatomic, strong) SnailQuickMaskPopups *popup;
@property (nonatomic, strong) PaymentChannelView *paymentChannelView;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    self.view.backgroundColor = themeGray;
    
    [self getOrderDetailData];
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
    OrderOfflineCourseModel *orderCourseModel = _orderModel.offlineCourse;
    NSInteger timestamp = [orderCourseModel.startTime integerValue];
    NSDictionary *modelDic = @{@"title":orderCourseModel.courseName,
                               @"courseId":_orderModel.offCourseId,
                               @"price":_orderModel.orderPrice,
                               @"time":[self handleDateWithTimeStamp:timestamp],
                               @"address":[NSString stringWithFormat:@"%@ %@",_orderModel.provinceName, orderCourseModel.address]};
    NSDictionary *payOrderModelDic = @{@"offlineCourseOrderId":_orderModel.offCourseOrderId,
                                       @"channel":_orderModel.payPlafrom,
                                       @"charge":_orderModel.charge};
    
    PaymentInfoModel *paymentInfoModel = [PaymentInfoModel yy_modelWithDictionary:modelDic];
    PayOrderModel *payOrderModel = [PayOrderModel yy_modelWithDictionary:payOrderModelDic];
    _paymentChannelView = [UIView paymentChannelView];
    _paymentChannelView.delegate = self;
    _paymentChannelView.paymentInfoModel = paymentInfoModel;
    _paymentChannelView.chargePay = YES;
    _paymentChannelView.payOrderModel = payOrderModel;
    _popup = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_paymentChannelView];
    _popup.isAllowPopupsDrag = YES;
    _popup.dampingRatio = 0.9;
    _popup.presentationStyle = PresentationStyleBottom;
    [_popup presentAnimated:YES completion:nil];

}


#pragma mark - 获取订单详情
- (void)getOrderDetailData{
    QueryOffLineCourseOrderDetailApi *queryOffLineCourseOrderDetailApi = [[QueryOffLineCourseOrderDetailApi alloc]initWithOffCourseOrderId:_orderId];
    [queryOffLineCourseOrderDetailApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
            return;
        }
        
        _orderModel = [OrderModel yy_modelWithDictionary:dataDic[@"object"]];
        
        _orderDetailTableView = [[OrderDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain orderModel:_orderModel];
        [self.view addSubview:_orderDetailTableView];
        
        [self setupPayButton];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:nil];
    }];
}

#pragma mark - 重新登录
- (void)login{
    NewLoginViewController *loginVC = [[NewLoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

#pragma mark - PaymentChannelViewDelegate
- (void)paymentViewFinishPayWithResult:(NSString *)result payOrderModel:(PayOrderModel *)payOrderModel{
    [_popup dismissAnimated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        [self getOrderDetailData];
    }];
}

- (void)loginFailed{
    [_popup dismissAnimated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        [self login];
    }];
}


- (NSString *)handleDateWithTimeStamp:(NSInteger)timeStamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp/1000.0];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}



@end
