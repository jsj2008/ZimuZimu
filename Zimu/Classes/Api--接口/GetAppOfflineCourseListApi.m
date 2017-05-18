//
//  GetAppOfflineCourseListApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetAppOfflineCourseListApi.h"

@implementation GetAppOfflineCourseListApi

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl{
    return GetAppOfflineCourseListURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}


@end
