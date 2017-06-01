//
//  PaymentChannelView.h
//  Zimu
//
//  Created by Redpower on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentInfoModel.h"
#import "PayOrderModel.h"



@protocol PaymentChannelViewDelegate <NSObject>

- (void)paymentViewFinishPayWithResult:(NSString *)result payOrderModel:(PayOrderModel *)payOrderModel;

- (void)loginFailed;

@end

@interface PaymentChannelView : UIView

@property (nonatomic, copy) NSString *price;

@property (nonatomic, strong) PaymentInfoModel *paymentInfoModel;


//重新支付
@property (nonatomic, assign) BOOL chargePay;       //是否通过charge支付
@property (nonatomic, strong) PayOrderModel *payOrderModel;
//@property (nonatomic, copy) NSString *charge;

@property (nonatomic, weak) id<PaymentChannelViewDelegate> delegate;

@end
