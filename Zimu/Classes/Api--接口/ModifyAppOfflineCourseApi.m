//
//  ModifyAppOfflineCourseApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ModifyAppOfflineCourseApi.h"

@implementation ModifyAppOfflineCourseApi{
    NSString *_offCourseOrderId;
    NSString *_offlineCourseName;
    NSString *_channel;
}

- (instancetype)initWithOffCourseOrderId:(NSString *)offCourseOrderId channel:(NSString *)channel offlineCourseName:(NSString *)offlineCourseName{
    self = [super init];
    if (self) {
        _offCourseOrderId = offCourseOrderId;
        _offlineCourseName = offlineCourseName;
        _channel = channel;
    }
    return self;
}

- (NSString *)requestUrl{
    return ModifyAppOfflineCourseURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (id)requestArgument{
    return @{@"offCourseOrderId":_offCourseOrderId,
             @"offlineCourseName":_offlineCourseName,
             @"channel":_channel,
             @"userToken":userToken};
}

@end
