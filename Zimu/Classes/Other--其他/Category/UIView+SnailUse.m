//
//  UIView+SnailUse.m
//  Zimu
//
//  Created by Redpower on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "UIView+SnailUse.h"
#import "PaymentChannelView.h"

@implementation UIView (SnailUse)

+ (id)paymentChannelView{
    PaymentChannelView *view = [[PaymentChannelView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    
    return view;
}

@end
