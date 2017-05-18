//
//  GetHotVideoApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetHotVideoApi.h"

@implementation GetHotVideoApi

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl{
    return GetHotVideoURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

@end
