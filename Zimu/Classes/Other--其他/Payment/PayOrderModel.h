//
//  PayOrderModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayOrderModel : NSObject

@property (nonatomic, strong) NSString *channel;            //支付方式
@property (nonatomic, strong) NSString *charge;             //支付凭证
@property (nonatomic, strong) NSString *offlineCourseOrderId;   //订单ID

@end
