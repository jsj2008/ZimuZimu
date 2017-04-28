//
//  InsertQuestionApi.m
//  Zimu
//
//  Created by Redpower on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "InsertQuestionApi.h"

@implementation InsertQuestionApi{
    NSString *_userId;
    NSString *_questionTitle;
    NSString *_keyWord;
    NSString *_questioVal;
}

- (instancetype)initWithUserId:(NSString *)userId questionTitle:(NSString *)questionTitle keyWord:(NSString *)keyWord questionVal:(NSString *)questionVal{
    if (self = [super init]) {
        
        _userId = userId;
        _questionTitle = questionTitle;
        _keyWord = keyWord;
        _questioVal = questionVal;
    }
    return self;
}

- (NSString *)requestUrl{
    return InsertQuestionURL;
}

- (id)requestArgument{
    return @{@"userId":_userId,
             @"questionTitle":_questionTitle,
             @"keyWord":_keyWord,
             @"questionVal":_questioVal};
}

@end
