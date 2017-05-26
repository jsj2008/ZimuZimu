//
//  QueryAppUserOrderListApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface QueryAppUserOrderListApi : YTKRequest

- (instancetype)initWithEndTime:(NSString *)endTime;

@end
