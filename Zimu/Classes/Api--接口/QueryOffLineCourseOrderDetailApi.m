//
//  QueryOffLineCourseOrderDetailApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QueryOffLineCourseOrderDetailApi.h"

@implementation QueryOffLineCourseOrderDetailApi{
    NSString *_offCourseOrderId;
}

- (instancetype)initWithOffCourseOrderId:(NSString *)offCourseOrderId{
    self = [super init];
    if (self) {
        _offCourseOrderId = offCourseOrderId;
    }
    return self;
}

- (NSString *)requestUrl{
    return QueryOffLineCourseOrderDetailURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{@"offCourseOrderId":_offCourseOrderId};
}

@end
