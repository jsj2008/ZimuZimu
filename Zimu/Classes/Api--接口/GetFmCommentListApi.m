//
//  GetFmCommentListApi.m
//  Zimu
//
//  Created by Redpower on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "GetFmCommentListApi.h"

@implementation GetFmCommentListApi{
    NSString *_fmId;
}

- (instancetype)initWithFMId:(NSString *)fmId{
    self = [super init];
    if (self) {
        _fmId = fmId;
    }
    return self;
}

- (id)requestArgument{
    return @{@"fmId":_fmId};
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (NSString *)requestUrl{
    return GetFmCommentListURL;
}

@end
