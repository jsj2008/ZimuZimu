//
//  GetMyMsgApi.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetMyMsgApi.h"

@implementation GetMyMsgApi{
    NSString *_endTime;
}

- (instancetype)initWithEndTime:(NSString *)endTime{
    self = [super init];
    if (self) {
        _endTime = endTime;
    }
    return self;
}
- (NSString *)requestUrl{
    return GetMyMsgURL;
}

- (id)requestArgument{
    NSLog(@"%@", userToken);
    return @{@"userToken":userToken,
             @"endTime":_endTime};
}
- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
@end
