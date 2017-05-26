//
//  PaymentChannelView.h
//  Zimu
//
//  Created by Redpower on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentInfoModel.h"

@protocol PaymentChannelViewDelegate <NSObject>

- (void)paymentViewFinishPayWithResult:(NSString *)result;

- (void)loginFailed;

@end

@interface PaymentChannelView : UIView

@property (nonatomic, copy) NSString *price;

@property (nonatomic, strong) PaymentInfoModel *paymentInfoModel;

@property (nonatomic, weak) id<PaymentChannelViewDelegate> delegate;

@end
