//
//  QuestionUserCommentApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QuestionUserCommentApi.h"

@implementation QuestionUserCommentApi{
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
    return AppUserCommentURL;
}

- (id)requestArgument{
    return @{@"questionId":_questionId};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}


@end
