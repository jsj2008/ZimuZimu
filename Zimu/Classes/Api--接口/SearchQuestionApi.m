//
//  SearchQuestionApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SearchQuestionApi.h"

@implementation SearchQuestionApi{
    NSString *_questionTitle;
}

- (instancetype)initWithQuestionTitle:(NSString *)questionTitle{
    self = [super init];
    if (self) {
        _questionTitle = questionTitle;
    }
    return self;
}

- (NSString *)requestUrl{
    return AppExpSolveURL;
}

- (id)requestArgument{
    return @{@"questionTitle":_questionTitle};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
