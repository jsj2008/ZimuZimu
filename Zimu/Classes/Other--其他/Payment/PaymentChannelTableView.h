//
//  PaymentChannelTableView.h
//  Zimu
//
//  Created by Redpower on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaymentChannelDelegate <NSObject>

- (void)selectPaymentChannel:(NSString *)channel;

@end

@interface PaymentChannelTableView : UITableView

@property (nonatomic, copy) NSString *channel;

@property (nonatomic, assign) id<PaymentChannelDelegate> channelDelegate;

@end
