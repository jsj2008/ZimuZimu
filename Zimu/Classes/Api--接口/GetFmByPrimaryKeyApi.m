//
//  GetFmByPrimaryKeyApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetFmByPrimaryKeyApi.h"

@implementation GetFmByPrimaryKeyApi{
    NSString *_fmId;
}

- (instancetype)initWithFMId:(NSString *)fmId{
    self = [super init];
    if (self) {
        _fmId = fmId;
    }
    return self;
}

- (NSString *)requestUrl{
    return GetFmByPrimaryKeyURL;
}

- (id)requestArgument{
    return @{@"fmId":_fmId};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

@end
