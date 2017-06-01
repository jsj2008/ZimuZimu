//
//  GetQuestionLabelApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetQuestionLabelApi.h"

@implementation GetQuestionLabelApi

- (instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}

- (NSString *)requestUrl{
    return GetQuestionLabelURL;
}


- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

@end
