//
//  CareQuestionApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CareQuestionApi.h"

@implementation CareQuestionApi{
    NSString *_questionId;
}

- (instancetype)initWithQuestionId:(NSString *)questionId{
    self = [super init];
    if (self) {
        _questionId = questionId;
    }
    return self;
}

- (NSString *)requestUrl{
    return CareQuestionURL;
}

- (id)requestArgument{
    return @{@"questionId":_questionId,
             @"userToken":userToken};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
