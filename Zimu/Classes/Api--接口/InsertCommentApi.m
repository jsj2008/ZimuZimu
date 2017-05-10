//
//  InsertCommentApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/4.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "InsertCommentApi.h"

@implementation InsertCommentApi{
    NSString *_commentVal;
    NSString *_questionId;
}

- (instancetype)initWithCommentVal:(NSString *)commentVal questionId:(NSString *)questionId{
    self = [super init];
    if (self) {
        _commentVal = commentVal;
        _questionId = questionId;
    }
    return self;
}

- (NSString *)requestUrl{
    return InsertCommentURL;
}

- (id)requestArgument{
    return @{@"commentVal":_commentVal,
             @"questionId":_questionId,
             @"userToken":userToken};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
