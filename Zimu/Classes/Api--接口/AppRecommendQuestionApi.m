//
//  AppRecommendQuestionApi.m
//  Zimu
//
//  Created by Redpower on 2017/6/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AppRecommendQuestionApi.h"

@implementation AppRecommendQuestionApi{
    NSString *_categoryId;
    NSString *_questionId;
}

- (instancetype)initWithCategoryId:(NSString *)categoryId questionId:(NSString *)questionId{
    self = [super init];
    if (self) {
        _categoryId = categoryId;
        _questionId = questionId;
    }
    return self;
}

- (NSString *)requestUrl{
    return AppRecommendQuestionURL;
}

- (id)requestArgument{
    return @{@"categoryId":_categoryId,
             @"questionId":_questionId};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}


@end
