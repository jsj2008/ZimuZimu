//
//  QueryMyQuestionApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QueryMyQuestionApi.h"

@implementation QueryMyQuestionApi{
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
    return QueryMyQuestionURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{@"endTime":_endTime,
             @"userToken":userToken};
}

@end
