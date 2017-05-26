//
//  WXOfflineCourseApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "WXOfflineCourseApi.h"

@implementation WXOfflineCourseApi{
    NSString *_offlineCourseId;
    NSString *_offlineCourseName;
    NSString *_offCoursePrice;
    NSString *_channel;
}

- (instancetype)initWithOfflineCourseId:(NSString *)offlineCourseId offlineCourseName:(NSString *)offlineCourseName offCoursePrice:(NSString *)offCoursePrice channel:(NSString *)channel{
    self = [super init];
    if (self) {
        _offlineCourseId = offlineCourseId;
        _offlineCourseName = offlineCourseName;
        _offCoursePrice = offCoursePrice;
        _channel = channel;
    }
    return self;
}

- (NSString *)requestUrl{
    return WXOfflineCourseURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (id)requestArgument{
    return @{@"offlineCourseId":_offlineCourseId,
             @"offlineCourseName":_offlineCourseName,
             @"offCoursePrice":_offCoursePrice,
             @"channel":_channel,
             @"userToken":userToken};
}

@end
