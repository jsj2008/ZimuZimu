//
//  GetOfflineCourseByIdApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetOfflineCourseByIdApi.h"

@implementation GetOfflineCourseByIdApi{
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
    return GetOfflineCourseByIdURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{@"offCourseId":_courseId};
}

@end
