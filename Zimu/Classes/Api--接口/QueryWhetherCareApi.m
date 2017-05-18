//
//  QueryWhetherCareApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QueryWhetherCareApi.h"

@implementation QueryWhetherCareApi{
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
    return QueryWhetherCareURL;
}

- (id)requestArgument{
    return @{@"questionId":_questionId,
             @"userToken":userToken};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}


@end
