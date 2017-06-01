//
//  ZimuPayManager.m
//  Zimu
//
//  Created by Redpower on 2017/5/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZimuPayManager.h"
#import "Pingpp.h"
#import "WXOfflineCourseApi.h"
#import "PaymentInfoModel.h"
#import "MBProgressHUD+MJ.h"
#import "NewLoginViewController.h"
#import "PayOrderModel.h"
#import "ModifyAppOfflineCourseApi.h"

#define kWaiting          @"正在获取支付凭据,请稍后..."
#define kNote             @"提示"
#define kConfirm          @"确定"
#define kErrorNet         @"网络错误"
#define kResult           @"支付结果：%@"

#warning \
URL Schemes 需要在 Xcode 的 Info 标签页的 URL Types 中添加，\
需要你自定义（不能使用 "alipay", "wx", "wechat" 等等这些），首字母必须是英文字母，支持英文和数字，不建议使用特殊符号。\
如果这个不设置，可能会导致支付完成之后，无法跳转回 App 或者无法得到结果回调。\
对于微信支付来说，必须添加一项值为微信平台上注册的应用程序 id（"wx" 开头的字符串）作为 URL Scheme。
#define kUrlScheme      @"wxf3b92b17e0cdf08b" // 这个是你定义的 URL Scheme，支付宝、微信支付、银联和测试模式需要。

//#define kUrl            @"http://218.244.151.190/demo/charge" // 你的服务端创建并返回 charge 的 URL 地址，此地址仅供测试用。

@interface ZimuPayManager ()

@property (nonatomic, strong) UIAlertView *mAlert;

@end

@implementation ZimuPayManager

//- (void)submitOrder{
//
//}

//原有支付方式重新支付
- (void)normalPayWithViewController:(UIViewController *)viewController charge:(NSString *)charge payOrderModel:(PayOrderModel *)payOrderModel{

    ZimuPayManager *__weak weakSelf = self;
    [Pingpp createPayment:charge
           viewController:viewController
             appURLScheme:kUrlScheme
           withCompletion:^(NSString *result, PingppError *error) {
               NSLog(@"completion block: %@", result);
               if (error == nil) {
                   NSLog(@"PingppError is nil");
               } else {
                   NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
               }
               
               if ([self.delegate respondsToSelector:@selector(zimuPayManager:finishPay:payOrderModel:)]) {
                   [self.delegate zimuPayManager:weakSelf finishPay:result payOrderModel:payOrderModel];
               }
               
               if ([result isEqualToString:@"fail"]) {
                   result = @"支付失败";
               }else if ([result isEqualToString:@"success"]){
                   result = @"支付成功";
               }else if ([result isEqualToString:@"cancel"]){
                   result = @"取消支付";
               }
               [MBProgressHUD showSuccess:result toView:viewController.view];
               
           }];

}

//修改订单支付方式后重新支付
- (void)normalPayWithViewController:(UIViewController *)viewController PaymentInfoModel:(PaymentInfoModel *)paymentInfoModel channel:(NSString *)channel offCourseOrderId:(NSString *)offCourseOrderId{
    ZimuPayManager *__weak weakSelf = self;
    //修改订单
    ModifyAppOfflineCourseApi *modifyAppOfflineCourseApi = [[ModifyAppOfflineCourseApi alloc]initWithOffCourseOrderId:offCourseOrderId channel:channel offlineCourseName:paymentInfoModel.title];
    [weakSelf showAlertWait];
    [modifyAppOfflineCourseApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf hideAlert];
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:viewController.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:viewController.view];
            if ([self.delegate respondsToSelector:@selector(loginFailed)]) {
                [self.delegate loginFailed];
            }
            return;
        }
        PayOrderModel *payOrderModel = [PayOrderModel yy_modelWithDictionary:dataDic[@"object"]];
        NSString *charge = payOrderModel.charge;
        [Pingpp createPayment:charge
               viewController:viewController
                 appURLScheme:kUrlScheme
               withCompletion:^(NSString *result, PingppError *error) {
                   NSLog(@"completion block: %@", result);
                   if (error == nil) {
                       NSLog(@"PingppError is nil");
                   } else {
                       NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                   }
                   
                   if ([self.delegate respondsToSelector:@selector(zimuPayManager:finishPay:payOrderModel:)]) {
                       [self.delegate zimuPayManager:weakSelf finishPay:result payOrderModel:payOrderModel];
                   }
                   
                   if ([result isEqualToString:@"fail"]) {
                       result = @"支付失败";
                   }else if ([result isEqualToString:@"success"]){
                       result = @"支付成功";
                   }else if ([result isEqualToString:@"cancel"]){
                       result = @"取消支付";
                   }
                   [MBProgressHUD showSuccess:result toView:viewController.view];
                   
               }];

        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf hideAlert];
    }];
}


//提交订单支付
- (void)normalPayWithViewController:(UIViewController *)viewController PaymentInfoModel:(PaymentInfoModel *)paymentInfoModel channel:(NSString *)channel{
    ZimuPayManager *__weak weakSelf = self;
    WXOfflineCourseApi *wxOfflineCourseApi = [[WXOfflineCourseApi alloc]initWithOfflineCourseId:paymentInfoModel.courseId offlineCourseName:paymentInfoModel.title offCoursePrice:@"0.01" channel:channel];//paymentInfoModel.price
    
    [weakSelf showAlertWait];
    [wxOfflineCourseApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf hideAlert];
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错，请稍后再试" toView:nil];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:nil];
            if ([self.delegate respondsToSelector:@selector(loginFailed)]) {
                [self.delegate loginFailed];
            }
            
            return;
        }
        PayOrderModel *payOrderModel = [PayOrderModel yy_modelWithDictionary:dataDic[@"object"]];
        NSString *charge = payOrderModel.charge;
        [Pingpp createPayment:charge
               viewController:viewController
                 appURLScheme:kUrlScheme
               withCompletion:^(NSString *result, PingppError *error) {
                   NSLog(@"completion block: %@", result);
                   if (error == nil) {
                       NSLog(@"PingppError is nil");
                   } else {
                       NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                   }
                   
                   if ([self.delegate respondsToSelector:@selector(zimuPayManager:finishPay:payOrderModel:)]) {
                       [self.delegate zimuPayManager:weakSelf finishPay:result payOrderModel:payOrderModel];
                   }
                   
                   if ([result isEqualToString:@"fail"]) {
                       result = @"支付失败";
                   }else if ([result isEqualToString:@"success"]){
                       result = @"支付成功";
                   }else if ([result isEqualToString:@"cancel"]){
                       result = @"取消支付";
                   }
                   [MBProgressHUD showSuccess:result toView:viewController.view];
                   
               }];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf hideAlert];
    }];
}

- (void)showAlertMessage:(NSString*)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        _mAlert = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:nil cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
        [_mAlert show];        
    });
}


- (void)showAlertWait{
    dispatch_async(dispatch_get_main_queue(), ^{
        _mAlert = [[UIAlertView alloc] initWithTitle:kWaiting message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
        [_mAlert show];
        UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        aiv.center = CGPointMake(_mAlert.frame.size.width / 2.0f - 15, _mAlert.frame.size.height / 2.0f + 10 );
        [aiv startAnimating];
        [_mAlert addSubview:aiv];
    });
}

- (void)hideAlert{
    if (_mAlert != nil){
        dispatch_async(dispatch_get_main_queue(), ^{
            [_mAlert dismissWithClickedButtonIndex:0 animated:YES];
            _mAlert = nil;
        });
    }
}



@end
