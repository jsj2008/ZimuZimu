//
//  GetExpertByPrimaryKeyApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetExpertByPrimaryKeyApi.h"

@implementation GetExpertByPrimaryKeyApi{
    NSString *_expertId;
}

- (instancetype)initWithExpertId:(NSString *)expertId{
    self = [super init];
    if (self) {
        _expertId = expertId;
    }
    return self;
}

- (NSString *)requestUrl{
    return GetExpertByPrimaryKeyURL;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{@"expertId":_expertId};
}

@end
