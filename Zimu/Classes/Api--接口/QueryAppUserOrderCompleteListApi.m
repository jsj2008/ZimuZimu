//
//  QueryAppUserOrderCompleteListApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QueryAppUserOrderCompleteListApi.h"

@implementation QueryAppUserOrderCompleteListApi{
    NSString *_endTime;
    NSString *_status;
}

- (instancetype)initWithEndTime:(NSString *)endTime status:(NSString *)status{
    self = [super init];
    if (self) {
        _endTime = endTime;
        _status = status;
    }
    return self;
}

- (NSString *)requestUrl{
    return QueryAppUserOrderCompleteListURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{@"endTime":_endTime,
             @"status":_status,
             @"userToken":userToken};
}

@end
