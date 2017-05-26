//
//  GetAppOfflineCourseByIdApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetAppOfflineCourseByIdApi.h"

@implementation GetAppOfflineCourseByIdApi{
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
    return GetAppOfflineCourseByIdURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{@"categoryId":_categoryId};
}

@end
