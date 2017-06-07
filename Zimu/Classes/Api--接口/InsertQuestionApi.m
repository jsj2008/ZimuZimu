//
//  InsertQuestionApi.m
//  Zimu
//
//  Created by Redpower on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "InsertQuestionApi.h"

@implementation InsertQuestionApi{
    NSString *_questionTitle;
    NSString *_categoryId;
    NSString *_questioVal;
}

- (instancetype)initWithQuestionTitle:(NSString *)questionTitle categoryId:(NSString *)categoryId questionVal:(NSString *)questionVal{
    if (self = [super init]) {
        
        _questionTitle = questionTitle;
        _categoryId = categoryId;
        _questioVal = questionVal;
    }
    return self;
}

- (NSString *)requestUrl{
    return InsertQuestionURL;
}

- (id)requestArgument{
    return @{
             @"questionTitle":_questionTitle,
             @"categoryId":_categoryId,
             @"questionVal":_questioVal,
             @"userToken":userToken};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
