//
//  QueryAppUserOrderCompleteListApi.h
//  Zimu
//
//  Created by Redpower on 2017/5/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface QueryAppUserOrderCompleteListApi : YTKRequest

- (instancetype)initWithEndTime:(NSString *)endTime status:(NSString *)status;

@end



