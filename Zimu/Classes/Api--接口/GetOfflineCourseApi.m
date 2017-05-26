//
//  GetOfflineCourseApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetOfflineCourseApi.h"

@implementation GetOfflineCourseApi{
    NSString *_categoryId;
}

- (instancetype)initWithCategoryId:(NSString *)categoryId{
    self = [super init];
    if (self) {
        _categoryId = categoryId;
    }
    return self;
}

- (NSString *)requestUrl{
    return GetOfflineCourseURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{@"categoryId":_categoryId};
}


@end
