//
//  ZimuPayManager.h
//  Zimu
//
//  Created by Redpower on 2017/5/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZimuPayManager;
@class PaymentInfoModel;    //订单信息数据
@class PayOrderModel;       //提交订单后获取的数据

@protocol ZimuPayManagerDelegate <NSObject>

- (void)zimuPayManager:(ZimuPayManager *)manager finishPay:(NSString *)result payOrderModel:(PayOrderModel *)payOrderModel;

//未登录或登录过期
- (void)loginFailed;

@end


@interface ZimuPayManager : NSObject


@property (nonatomic, weak) id<ZimuPayManagerDelegate> delegate;

/**
 *  支付
 *  订单提交后调用
 *  viewController      调用支付时所在的VC
 *  charge              订单提交后，服务器从ping++拿回的charge
 */
- (void)normalPayWithViewController:(UIViewController *)viewController charge:(NSString *)charge payOrderModel:(PayOrderModel *)payOrderModel;

/**
 *  重新支付
 *  线下课程报名
 *  viewController      调用支付时所在的VC
 *  paymentInfoModel    订单信息，提交订单时用到
 *  channel             支付方式 (wx、alipay)
 *  offCourseOrderId    订单ID
 */
- (void)normalPayWithViewController:(UIViewController *)viewController PaymentInfoModel:(PaymentInfoModel *)paymentInfoModel channel:(NSString *)channel offCourseOrderId:(NSString *)offCourseOrderId;

/**
 *  支付
 *  线下课程报名
 *  viewController      调用支付时所在的VC
 *  paymentInfoModel    订单信息，提交订单是用到
 *  channel             支付方式 (wx、alipay)
 */
- (void)normalPayWithViewController:(UIViewController *)viewController PaymentInfoModel:(PaymentInfoModel *)paymentInfoModel channel:(NSString *)channel;

@end
