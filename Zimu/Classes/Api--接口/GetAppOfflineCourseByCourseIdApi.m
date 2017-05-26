//
//  GetAppOfflineCourseByCourseIdApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetAppOfflineCourseByCourseIdApi.h"

@implementation GetAppOfflineCourseByCourseIdApi{
    NSString *_courseId;
}

- (instancetype)initWithCourseId:(NSString *)courseId{
    self = [super init];
    if (self) {
        _courseId = courseId;
    }
    return self;
}

- (NSString *)requestUrl{
    return GetAppOfflineCourseByCourseIdURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{@"courseId":_courseId};
}

@end
